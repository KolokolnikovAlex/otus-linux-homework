
#task1

sudo cp /vagrant/task1/log_scan /etc/sysconfig/
sudo cp /vagrant/task1/log_scan.service /vagrant/task1/log_scan.timer /etc/systemd/system/
sudo cp /vagrant/task1/log_scan.sh /tmp/log_scan.sh
sudo chmod a+x /tmp/log_scan.sh

sudo systemctl daemon-reload
sudo systemctl start log_scan
sudo systemctl enable log_scan

#task2 
sudo yum install -y epel-release
sudo yum install -y spawn-fcgi
sudo cp /vagrant/task2/spawn-fcgi.service /etc/systemd/system/

#task3
sudo setenforce 0

sudo yum install -y httpd

sudo cp -r /etc/httpd /etc/httpd1
sudo cp -r /etc/httpd /etc/httpd2

sudo mv /vagrant/task3/httpd1.conf /etc/httpd1/conf/httpd.conf
sudo mv /vagrant/task3/httpd2.conf /etc/httpd2/conf/httpd.conf

sudo cp /vagrant/task3/httpd@.service /usr/lib/systemd/system/

sudo systemctl daemon-reload
sudo systemctl start httpd@1.service
sudo systemctl start httpd@2.service