# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|


    config.vm.define "playground" do |host|
      host.vm.box = "ubuntu/trusty64"
      #host.vm.network "private_network", ip: "192.168.33.201"
      host.vm.hostname = "playground"

      host.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
      end

      config.vm.network "forwarded_port", guest: 8080, host: 8080
      config.vm.network "forwarded_port", guest: 80, host: 80
      config.vm.network "forwarded_port", guest: 443, host: 443
      config.vm.network "forwarded_port", guest: 5432, host: 5432

      config.vm.synced_folder "..", "/parent"

    config.vm.provision "shell", inline: <<-SHELL
        # install docker 1.12 beta
        curl -fsSL https://test.docker.com/ | sh
        sudo usermod -aG docker vagrant

        curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
        curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose

        ln -s /vagrant/vagrantbin/dockerremovedanglingimages /usr/local/bin/dockerremovedanglingimages
        ln -s /vagrant/vagrantbin/dockerremovevolumes /usr/local/bin/dockerremovevolumes
    SHELL
  end
end