


Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian10"
  config.vm.box_check_update = false

  config.vm.define "master" do |master|
    master.vm.hostname = "wiki"
    master.vm.network "private_network", ip: "192.168.33.10"
    master.vm.network "forwarded_port", guest: 80, host: 8181
    master.vm.provision :shell, path: "crontab.sh", privileged: false
  end

  config.vm.define "backup" do |backup|
    backup.vm.hostname = "backup"
    backup.vm.network "private_network", ip: "192.168.33.11"
    backup.vm.network "forwarded_port", guest: 80, host: 8282
  end

  config.vm.provision "shell", inline: <<-SHELL
    export DEBIAN_FRONTEND=noninteractive

    echo "==> Mise à jour"
    sudo apt-get update -y

    echo "==> Installation des dépendances"
    sudo apt-get install php-geshi -y

    echo "==> Téléchargement et extraction de Dokuwiki"
    cd /tmp
    wget https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz
    tar -xvf dokuwiki-stable.tgz

    echo "==> Déplacement de Dokuwiki"
    sudo rm /var/www/html/index.html
    sudo cp -r dokuwiki-2018-04-22b/* /var/www/html/
    sudo chown -R vagrant:www-data /var/www/html/
    SHELL


    # ssh
    config.ssh.insert_key = false
    config.ssh.private_key_path = ["./id_rsa", "~/.vagrant.d/insecure_private_key"]
    config.vm.provision "file", source: "./id_rsa", destination: "/home/vagrant/.ssh/id_rsa"
    config.vm.provision "file", source: "./id_rsa.pub", destination: "/home/vagrant/.ssh/authorized_keys"
    config.vm.provision "file", source: "./id_rsa.pub", destination: "/home/vagrant/.ssh/id_rsa.pub"
    config.vm.provision :shell, path: "ssh.sh", privileged: false
  end


