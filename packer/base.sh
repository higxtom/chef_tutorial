/usr/sbin/setenforce 0
sudo sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
sudo sed -i "s/#UseDNS yes/UseDNS no/" /etc/ssh/sshd_config

cat << EOM | sudo tee -a /etc/yum.repos.d/epel.repo
[epel]
name=epel
baseurl=http://download.fedoraproject.org/pub/epel/5/\$basearch
enabled=0
gpgcheck=0
EOM

mkdir -pm 700 /home/vagrant/.ssh
wget --no-check-certificate 'http://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

cd /tmp
sudo mount -o loop /home/vagrant/VBoxGuestAdditions.iso /mnt
sudo sh /mnt/VBoxLinuxAddtions.run --nox11
sudo umount /mnt
sudo /etc/rc.d/init.d/vboxadd setup

# chef
curl -L https://www.opscode.com/chef/install.sh | sudo bash

