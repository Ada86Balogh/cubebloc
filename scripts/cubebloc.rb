class Cubebloc
  def Cubebloc.configure(config, settings)

    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
    config.ssh.forward_agent = true

    config.vm.box = settings["box"] ||= "adamoa/cubebloc"
    config.vm.box_version = settings["version"] ||= ">= 1.2.0"
    config.vm.hostname = settings["name"] ||= "cubebloc"

    config.vm.network "private_network", ip: settings["ip"] ||= "192.168.40.10"

    if settings.include? 'authorize'
      if File.exists? File.expand_path(settings["authorize"])
        config.vm.provision "shell" do |s|
          s.inline = "echo $1 | grep -xq \"$1\" /home/vagrant/.ssh/authorized_keys || echo $1 | tee -a /home/vagrant/.ssh/authorized_keys"
          s.args = [File.read(File.expand_path(settings["authorize"]))]
        end
      end
    end

    if settings.include? 'keys'
      settings["keys"].each do |key|
        config.vm.provision "shell" do |s|
          s.privileged = false
          s.inline = "echo \"$1\" > /home/vagrant/.ssh/$2 && chmod 600 /home/vagrant/.ssh/$2"
          s.args = [File.read(File.expand_path(key)), key.split('/').last]
        end
      end
    end

    if settings.has_key?("ports")
      settings["ports"].each do |port|
        config.vm.network "forwarded_port", guest: port["guest"], host: port["host"], protocol: port["protocol"], auto_correct: true
      end
    end

    if settings.include? 'folders'
      settings["folders"].each do |folder|
        config.vm.synced_folder folder["host"], folder["guest"], :mount_options => ["dmode=777", "fmode=777"]
      end
    end

    config.vm.provider "virtualbox" do |vb|
      vb.name = settings["name"] ||= "cubebloc"

      vb.cpus = settings["cpus"] ||= "2"
      vb.memory = settings["memory"] ||= "2048"

      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
    end

    config.vm.provision "shell" do |s|
        s.path = "./scripts/clear-sites.sh"
    end

    settings["sites"].each do |site|
      config.vm.provision "shell" do |s|
        s.path = "./scripts/create-site.sh"
        s.args = [site["domain"], site["folder"]]
      end
    end

    if settings.has_key?("databases")
        settings["databases"].each do |db|
          config.vm.provision "shell" do |s|
            s.path = "./scripts/create-mysql.sh"
            s.args = [db]
          end

          config.vm.provision "shell" do |s|
            s.path = "./scripts/create-postgres.sh"
            s.args = [db]
          end
        end
    end

    config.vm.provision "shell" do |s|
      s.inline = "/usr/local/bin/composer self-update"
    end

  end
end
