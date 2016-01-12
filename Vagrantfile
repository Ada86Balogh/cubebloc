# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "adamoa/cubebloc"

  config.vm.hostname = "cubebloc"

  # config.vm.box_check_update = false

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 3306, host: 33060

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder "./projects", "/var/www/cubebloc", owner: "vagrant", group: "vagrant", :mount_options => ["dmode=777","fmode=777"]

  config.vm.provider "virtualbox" do |vb|
    vb.name = "cubebloc"

    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]

    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true

    # Customize the amount of memory on the VM:
    vb.cpus = "2"
    vb.memory = "2048"
  end                                                             
end
