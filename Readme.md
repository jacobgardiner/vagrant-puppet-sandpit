# puppet sandpit version 1

The point of this is to setup an environment where you can develop something using puppet locally, committing just the code changes to git.

## Setup

First, setup [Vagrant](https://www.vagrantup.com/docs/installation/) and [Virtualbox](https://www.virtualbox.org/wiki/Downloads) if you haven't already.

### Virtualbox configuration
This environment assumes a few things about your virtualbox setup, which are worth getting right. Not only because it'll make this environment work, but also you might find it convenient in general when spinning up VMs locally.

Virtualbox is configured with 2 adapters:
- Adapter 1 = Attached to NAT (this provides your VM with an internet connection, without bonding to the LAN)
- Adapter 2 = Host-only adapter so you can ssh directly to your VM, via the secondary interface.

Go into Virtualbox's preferences (Not the VM's preferences), Goto Network, Goto NAT networks and configure the nat network so that it supports DHCP, and just ensure that the subnet does not conflict with 192.168.56.0/24. Click OK and move onto the next bit.

Goto the Host-only networks tab, If you don't have a vboxnetX interface, create one. Then configure the vboxnetX interface so that:
- Your IP address is 192.168.56.1 / 255.255.255.0
- on the DHCP server tab, the server is enabled and it's address is: 192.168.56.1 / 255.255.255.0
- Again on the DHCP server tab, Lower bound address: 192.168.56.2, Upper address bound: 192.168.56.99

*I usually then configure my VMs on this network with static IPs in the 192.168.56.100-254 range*

That should hopefully be the end of your virtualbox config.

### A very short tutorial

Clone this project locally, create a branch for your dev, and then spin up the VM. It might take a little while to download the vagrant base box i've created, and also a little time to setup the VM.

```
git clone git@github.com:jacobgardiner/vagrant-puppet-sandpit.git
cd vagrant-puppet-sandpit
git checkout -B <branchname>
vagrant up --provision
```

Once this is completed, you can:
```
vagrant ssh
```


- Create your modules in the modules folder, once you drop them in, you can add the classes you create in the manifest ```manifests/init.pp```.
- There's an example motd module already there, so when you run ```vagrant up --provision``` Vagrant will run that module.
- SSH'ing to the vm via ```vagrant ssh``` will display you the MOTD (which is managed via the demo module i've put in the project to get you started), you'll have sudo to root.  
- You don't need to completely blow away the vagrant VM to kick off the provision script, and therefore your puppet dev every time - simply run `vagrant provision` in the project folder to re-provision the VM, with your new module(s).

### To speed up the provision process
- install the [vagrant-cachier](https://github.com/fgrehm/vagrant-cachier) plugin
- After you have done your initial ```vagrant up --provision``` you can probably uncomment the below line in the Vagrantfile (it should be line 25)

```
sb.vm.provision :shell, :path => "install-puppet.sh"
```

This prevents the bash script that i've got there from bootstrapping every time you're debugging an issue.
