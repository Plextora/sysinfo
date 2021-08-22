#vi /opt/scripts/system-info.sh

#!/bin/bash

clear

echo -e "-------------------------------System Information----------------------------"
echo -e "Hostname:\t\t"`hostname`
echo -e "Hostname:\t\t"`hostname` >> sysinfo.csv
echo -e "uptime:\t\t\t"`uptime | awk '{print $3,$4}' | sed 's/,//'`
echo -e "uptime:\t\t\t"`uptime | awk '{print $3,$4}' | sed 's/,//'` >> sysinfo.csv
echo -e "Manufacturer:\t\t"`cat /sys/class/dmi/id/chassis_vendor`
echo -e "Manufacturer:\t\t"`cat /sys/class/dmi/id/chassis_vendor` >> sysinfo.csv
echo -e "Product Name:\t\t"`cat /sys/class/dmi/id/product_name`
echo -e "Product Name:\t\t"`cat /sys/class/dmi/id/product_name` >> sysinfo.csv
echo -e "Version:\t\t"`cat /sys/class/dmi/id/product_version`
echo -e "Version:\t\t"`cat /sys/class/dmi/id/product_version` >> sysinfo.csv
echo -e "Serial Number:\t\t"`cat /sys/class/dmi/id/product_serial`
echo -e "Serial Number:\t\t"`cat /sys/class/dmi/id/product_serial` >> sysinfo.csv
echo -e "Machine Type:\t\t"`vserver=$(lscpu | grep Hypervisor | wc -l); if [ $vserver -gt 0 ]; then echo "VM"; else echo "Physical"; fi`
echo -e "Machine Type:\t\t"`vserver=$(lscpu | grep Hypervisor | wc -l); if [ $vserver -gt 0 ]; then echo "VM"; else echo "Physical"; fi` >> sysinfo.csv
echo -e "Operating System:\t"`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`
echo -e "Operating System:\t"`hostnamectl | grep "Operating System" | cut -d ' ' -f5-` >> sysinfo.csv
echo -e "Kernel:\t\t\t"`uname -r`
echo -e "Kernel:\t\t\t"`uname -r` >> sysinfo.csv
echo -e "Architecture:\t\t"`arch`
echo -e "Architecture:\t\t"`arch` >> sysinfo.csv
echo -e "Processor Name:\t\t"`awk -F':' '/^model name/ {print $2}' /proc/cpuinfo | uniq | sed -e 's/^[ \t]*//'`
echo -e "Processor Name:\t\t"`awk -F':' '/^model name/ {print $2}' /proc/cpuinfo | uniq | sed -e 's/^[ \t]*//'` >> sysinfo.csv
echo -e "Active User:\t\t"`w | cut -d ' ' -f1 | grep -v USER | xargs -n1`
echo -e "Active User:\t\t"`w | cut -d ' ' -f1 | grep -v USER | xargs -n1` >> sysinfo.csv
echo -e "System Main IP:\t\t"`hostname -I`
echo -e "System Main IP:\t\t"`hostname -I` >> sysinfo.csv
echo -e "                       ^^ DO NOT SHARE YOUR IP!! IT COULD BE USED TO TRACE YOUR LOCATION"
echo ""
echo -e "-------------------------------Disk Usage >80%-------------------------------"
df -Ph | sed s/%//g | awk '{ if($5 > 80) print $0;}'
df -Ph | sed s/%//g | awk '{ if($5 > 80) print $0;}' >> sysinfo.csv
echo ""

echo -e "-------------------------------For WWN Details-------------------------------"
vserver=$(lscpu | grep Hypervisor | wc -l)
if [ $vserver -gt 0 ]
then
echo "$(hostname) is a VM"
echo "$(hostname) is a VM" >> sysinfo.csv
else
cat /sys/class/fc_host/host?/port_name
fi
echo ""

echo -e "-------------------------------Oracle DB Instances---------------------------"
if id oracle >/dev/null 2>&1; then
/bin/ps -ef|grep pmon
then
else
echo "oracle user does not exist on $(hostname)
fi
echo ""

if (( $(cat /etc/*-release | grep -w "Oracle|Red Hat|CentOS|Fedora" | wc -l) > 0 ))
then
echo -e "-------------------------------Package Updates-------------------------------"
yum updateinfo summary | grep 'Security|Bugfix|Enhancement'
echo -e "-----------------------------------------------------------------------------"
else
echo -e "-------------------------------Package Updates-------------------------------"
cat /var/lib/update-notifier/updates-available
echo -e "-----------------------------------------------------------------------------"
fi