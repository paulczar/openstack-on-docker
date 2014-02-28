Vagrant.configure("2") do |config|
  dev_dir = ENV["VAGRANT_DEV_DIR"] || "#{ENV['HOME']}/dev"
  
  config.vm.define :docker do |docker|
    # precise64 base box, with saucy kernel installed, updated virtualbox guest additions, and apt updates
    # If you want to use something other than virtualbox, just install linux-{image,headers}-generic-lts-saucy
    # reboot, then install $vm utilities
    docker.vm.box = 'docker'
  end

  config.vm.network "private_network", ip: "192.168.0.4"
  config.vm.synced_folder dev_dir, "/data/dev", type: "nfs"

  config.vm.provider "virtualbox" do |v,o|
    o.vm.box_url = 'http://ad0aa5dd3337e66b1480-a8edc52000ffb652c3d7c76d3a4040f6.r98.cf2.rackcdn.com/teeth2.box'
    v.customize ["modifyvm", :id, "--memory", 2048]
    # added because https://github.com/dotcloud/docker/pull/1813
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  config.vm.provider "vmware_fusion" do |v,o|
    o.vm.box_url = 'http://ad0aa5dd3337e66b1480-a8edc52000ffb652c3d7c76d3a4040f6.r98.cf2.rackcdn.com/teeth2-vmware.box'
    v.customize ["modifyvm", :id, "--memory", 2048]
  end

  config.vm.provision "docker"

end
