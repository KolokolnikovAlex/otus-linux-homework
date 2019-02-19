#!/bin/bash

sudo yum install -y wget rpmdevtools rpm-build createrepo redhat-lsb gcc

wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm
wget https://www.openssl.org/source/latest.tar.gz

tar -xvf latest.tar.gz

sudo rpm -i nginx-1.14.1-1.el7_4.ngx.src.rpm

sudo yum-builddep /root/rpmbuild/SPECS/nginx.spec -y

sudo sed -i 's|--with-debug|--with-openssl=/home/vagrant/openssl-1.1.1a|' /root/rpmbuild/SPECS/nginx.spec

sudo rpmbuild -bb /root/rpmbuild/SPECS/nginx.spec

sudo yum -y localinstall /root/rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm

sudo mkdir /usr/share/nginx/html/repo
sudo cp /root/rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm /usr/share/nginx/html/repo/
sudo createrepo /usr/share/nginx/html/repo/

sudo sed -i '/index  index.html index.htm;/a autoindex on;' /etc/nginx/conf.d/default.conf
sudo systemctl start nginx

sudo cat >> /etc/yum.repos.d/custom.repo << EOF
[custom]
name=custom-repo
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF
