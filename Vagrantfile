# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'.freeze

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Use Ubuntu 14.04 Trusty Tahr 64-bit as our operating system
  config.vm.box = 'debian/stretch64'
  config.vm.provision 'shell', path: 'script/vagrant.sh'

  config.vm.hostname = 'restful'
  #config.vm.network 'private_network', ip: '192.168.88.88'
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  # Configurate the virtual machine to use 2GB of RAM
  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '2048']
  end

  # Forward the Rails server default port to the host
  config.vm.network :forwarded_port, guest: 3000, host: 3100
  config.vm.network :forwarded_port, guest: 3307, host: 3308
end
