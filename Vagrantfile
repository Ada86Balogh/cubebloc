Vagrant.configure(2) do |config|
  config.vm.box = "adamoa/cubebloc"

  config.vm.hostname = "cubebloc"

  config.vm.network "forwarded_port", guest: 80, host: 8000
  config.vm.network "forwarded_port", guest: 443, host: 4430
  config.vm.network "forwarded_port", guest: 3306, host: 33060

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder "./projects", "/var/www/cubebloc", owner: "vagrant", group: "vagrant", :mount_options => ["dmode=775", "fmode=666"]

  config.vm.provider "virtualbox" do |vb|
    vb.name = "cubebloc"

    vb.cpus = "2"
    vb.memory = "2048"
  end                                                             
end