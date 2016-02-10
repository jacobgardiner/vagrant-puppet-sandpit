# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect = true
  end

  config.vm.box = "psandpit.local"
  config.vm.define "psandpit.local" do |sb|
    sb.vm.box = "sl6-base"
    sb.vm.box_url = "https://jgsyd.s3.amazonaws.com/vagrant/sl6-base.box"
    sb.vm.hostname = "psandpit.local"
    sb.vm.network :private_network, ip: "192.168.56.169"
    sb.ssh.forward_agent = true

    sb.vm.provider :virtualbox do |vb|
      vb.gui = false
    end

    # Setup puppet
    sb.vm.provision :shell, :path => "install-puppet.sh"

    # Use puppet as provisioner
    sb.vm.provision "puppet" do |puppet|
      puppet.module_path = "modules"
      puppet.manifest_file = "site.pp"
      puppet.options = "--verbose --debug"
    end

  end
end
