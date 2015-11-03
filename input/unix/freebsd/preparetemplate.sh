#!/bin/csh
echo "/opt/ilab/sethostname.sh" >> /root/.cshrc

echo "root:\" >> /etc/gettytab
echo " :al=root:ht:np:sp#115200;" >> /etc/gettytab

sed -i ".bak" 's/^ttyv0.*$/ttyv0 "\/usr\/libexec\/getty root" cons25 on secure/g' /etc/ttys 
 
