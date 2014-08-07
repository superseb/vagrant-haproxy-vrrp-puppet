# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  #config.vm.box = "puphpet/centos65-x64"
  config.vm.box = "centos-64-x64-vbox4210"

  config.vm.provider "virtualbox" do |v| 
    v.customize ["modifyvm", :id, "--memory", 256]
  end 

  config.vm.define :haproxy01, primary: true do |haproxy_config|

    haproxy_config.vm.hostname = 'haproxy01'
    haproxy_config.vm.network :forwarded_port, guest: 8080, host: 8080
    haproxy_config.vm.network :forwarded_port, guest: 80, host: 8081
    haproxy_config.vm.network :private_network, ip: "172.28.33.10"
  end 

  config.vm.define :haproxy02, primary: true do |haproxy_config|
    haproxy_config.vm.hostname = 'haproxy02'
    haproxy_config.vm.network :forwarded_port, guest: 8080, host: 8082
    haproxy_config.vm.network :forwarded_port, guest: 80, host: 8083
    haproxy_config.vm.network :private_network, ip: "172.28.33.11"
  end 

  config.vm.define :web01 do |web01_config|

    web01_config.vm.hostname = 'web01'
    web01_config.vm.network :private_network, ip: "172.28.33.21"
  end 

  config.vm.define :web02 do |web02_config|

    web02_config.vm.hostname = 'web02'
    web02_config.vm.network :private_network, ip: "172.28.33.22"
  end 

  config.vm.provision "shell",
    inline: "iptables -F"

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path    = "modules"
    puppet.manifest_file  = "site.pp"
  end
end
