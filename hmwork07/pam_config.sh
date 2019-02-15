sudo useradd admin_test
echo admin | sudo passwd admin_test --stdin

sudo echo "*;*;"\!"admin;Wk" >> /etc/security/time.conf
sudo ex -s -c '2i|account            required        pam_time.so' -c x /etc/pam.d/sshd

sudo echo "cap_sys_admin admin_test" >> /etc/security/capability.conf
sudo ex -s -c '2i|auth            optional        pam_cap.so' -c x /etc/pam.d/su
