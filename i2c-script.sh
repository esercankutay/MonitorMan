echo "This script adds i2c to the groups, gives permissions on /dev/i2c-* for this group and add user to i2c"

if  cat /etc/group | grep -q 'i2c:'; then
    echo "i2c already exist in your groups.Skipping to add..."
else
    sudo groupadd i2c
fi
sudo chown :i2c /dev/i2c-*
sudo chmod a+rw /dev/i2c-*
echo Enter username:
read user_name
if  groups $user_name | grep -q 'i2c'; then 
    echo "$user_name is already a member of i2c group. Skipping to add..."
else
    sudo usermod -aG i2c $user_name
fi
sudo cp /usr/share/ddcutil/data/45-ddcutils-i2c.rules /etc/udev/rules.d
echo "Reboot your computer to changes take effect..."