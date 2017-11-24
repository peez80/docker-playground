# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  #################################################
  # Preconfigure RAM and CPUs depending on host machine

  # Set 1/2 RAM of host but max. 6GB
  mem_ratio = 0.5
  cpu_exec_cap = 75
  host = RbConfig::CONFIG['host_os']
  # Give VM 3/4 system memory & access to all cpu cores on the host
  if host =~ /darwin/
    cpus = `sysctl -n hw.ncpu`.to_i
    # sysctl returns Bytes and we need to convert to MB
    mem = `sysctl -n hw.memsize`.to_i / 1024^2 * mem_ratio
  elsif host =~ /linux/
    cpus = `nproc`.to_i
    # meminfo shows KB and we need to convert to MB
    mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 * mem_ratio
  else # Windows folks
    cpus = `wmic cpu get NumberOfCores`.split("\n")[2].to_i
    mem = `wmic OS get TotalVisibleMemorySize`.split("\n")[2].to_i
    mem = mem / 1024 * mem_ratio          
  end

  #Max 6 GB and max 4 CPUs
  mem = mem > 6000 ? 6000 : mem
  cpus = cpus > 4 ? 4 : cpus

  puts "Provisioning VM with #{cpus} CPU's (at #{cpu_exec_cap}%) and #{mem/1024} GB RAM."

  # ####### Mem and CPUs determined ############################################################



    config.vm.define "playground" do |host|
      host.vm.box = "ubuntu/xenial64"
      #host.vm.network "private_network", ip: "192.168.33.201"
      host.vm.hostname = "playground"

      host.vm.provider "virtualbox" do |v|
        v.memory = mem
        v.cpus = cpus
        v.customize ["modifyvm", :id, "--cpuexecutioncap", cpu_exec_cap]
      end

      config.vm.network "forwarded_port", guest: 8080, host: 8080
      config.vm.network "forwarded_port", guest: 80, host: 80
      config.vm.network "forwarded_port", guest: 443, host: 443
      config.vm.network "forwarded_port", guest: 5432, host: 5432
      config.vm.network "forwarded_port", guest: 2375, host: 2375

      config.vm.synced_folder "..", "/parent"

    config.vm.provision "shell", inline: <<-SHELL
      #install docker
      curl -fsSL https://get.docker.com/ | sh
      sudo usermod -aG docker ubuntu

      #expose dockerd on vm
      sudo mkdir -p /etc/systemd/system/docker.service.d
      sudo echo "[Service]" > /etc/systemd/system/docker.service.d/override.conf
      sudo echo "ExecStart=" >> /etc/systemd/system/docker.service.d/override.conf
      sudo echo "ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375" >> /etc/systemd/system/docker.service.d/override.conf
      sudo echo "" >> /etc/systemd/system/docker.service.d/override.conf

      # Install docker-compose
      curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
      chmod +x /usr/local/bin/docker-compose
      curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose

      # Link default scripts
      echo "Creating script links..."
      ln -s /vagrant/vagrantbin/dockerremovedanglingimages /usr/local/bin/dockerremovedanglingimages
      ln -s /vagrant/vagrantbin/dockerremovevolumes /usr/local/bin/dockerremovevolumes
      ln -s /vagrant/vagrantbin/install-kubernetes.sh /usr/local/bin/install-kubernetes

      echo "Provision finished"
    SHELL
  end
end