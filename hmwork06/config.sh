
#task1

sudo cp task1/log_scan /etc/sysconfig/
sudo cp task1/log_scan.service task1/log_scan.timer /etc/systemd/system/
sudo cp task1/log_scan.sh /tmp/log_scan.sh

sudo systemctl daemon-reload
sudo systemctl start log_scan
sudo systemctl enable log_scan

#task2 
sudo yum install epel-release
sudo yum install spawn-fcgi
sudo cp task2/spawn-fcgi.service /etc/systemd/system/

#task3
sudo yum install httpd
sudo cp task3/httpd-1 /etc/sysconfig/
sudo cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd-1.conf
#Can change new config file
sudo cp task3/httpd@.service /usr/lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start httpd@1
 

