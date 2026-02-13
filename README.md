## Ansible scripts to set up [fly.io](https://fly.io) [sprites](https://sprites.dev) with the tools, etc. I like.

### Notes on general server setup on remote Ubuntu servers at (say) OVH.

- “ansible webservers -m apt -a "upgrade=dist update_cache=yes”

Excerpt From
Ansible for DevOps
Jeff Geerling
This material may be protected by copyright.

----

From [40 Linux Security Tips](https://www.cyberciti.biz/tips/linux-security.html):

### List packages installed:

    dpkg --list
    dpkg --info packageName
    apt-get remove packageName

----

### Disable all unnecessary services and daemons (services that runs in the background). You need to remove all unwanted services from the system start-up. Type the following command to list all services which are started at boot time in run level # 3:

    chkconfig --list | grep '3:on'

To disable service, enter:

    service serviceName stop
    chkconfig serviceName off

----

### systemd based Linux distro and services

Modern Linux distros with systemd use the systemctl command for the same purpose.

Print a list of services that lists which runlevels each is configured on or off

    systemctl list-unit-files --type=service
    systemctl list-dependencies graphical.target

Turn off service at boot time

    systemctl disable service
    systemctl disable httpd.service

Start/stop/restart service

    systemctl disable service
    systemctl disable httpd.service

Get status of service

    systemctl status service
    systemctl status httpd.service

Viewing log messages

    journalctl
    journalctl -u network.service
    journalctl -u ssh.service
    journalctl -f
    journalctl -k

----

### Find Listening Network Ports

Use the following command to list all open ports and associated programs:

    netstat -tulpn

OR use the ss command as follows:

    ss -tulpn

OR

    nmap -sT -O localhost
    nmap -sT -O server.example.com

----

### Linux Kernel /etc/sysctl.conf Hardening

See link above for more details and links.

/etc/sysctl.conf file is used to configure kernel parameters at runtime. Linux reads and applies settings from /etc/sysctl.conf at boot time. Sample /etc/sysctl.conf:

    # Turn on execshield
    kernel.exec-shield=1
    kernel.randomize_va_space=1
    # Enable IP spoofing protection
    net.ipv4.conf.all.rp_filter=1
    # Disable IP source routing
    net.ipv4.conf.all.accept_source_route=0
    # Ignoring broadcasts request
    net.ipv4.icmp_echo_ignore_broadcasts=1
    net.ipv4.icmp_ignore_bogus_error_messages=1
    # Make sure spoofed packets get logged
    net.ipv4.conf.all.log_martians = 1

----

### Turn Off IPv6 only if you are NOT using it on Linux

See link above for more details and links.

----

### Disable Unwanted SUID and SGID Binaries

All SUID/SGID bits enabled file can be misused when the SUID/SGID executable has a security problem or bug. All local or remote user can use such file. It is a good idea to find all such files. Use the find command as follows:

    #See all set user id files:
    find / -perm +4000
    # See all group id files
    find / -perm +2000
    # Or combine both in a single command
    find / \( -perm -4000 -o -perm -2000 \) -print
    find / -path -prune -o -type f -perm +6000 -ls

You need to investigate each reported file. See reported file man page for further details.

----

### World-Writable Files on Linux Server

Anyone can modify world-writable file resulting into a security issue. Use the following command to find all world writable and sticky bits set files:

    find /dir -xdev -type d \( -perm -0002 -a ! -perm -1000 \) -print

You need to investigate each reported file and either set correct user and group permission or remove it.

----

### Noowner Files

Files not owned by any user or group can pose a security problem. Just find them with the following command which do not belong to a valid user and a valid group

    find /dir -xdev \( -nouser -o -nogroup \) -print

You need to investigate each reported file and either assign it to an appropriate user and group or remove it.

----

### Disable unused services

You can disable unused services using the service command/systemctl command:
    
    sudo systemctl stop service
    sudo systemctl disable service

For example, if you are not going to use Nginx service for some time disable it:
    
    sudo systemctl stop nginx
    sudo systemctl disable nginx
