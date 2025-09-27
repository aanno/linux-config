#!/bin/bash -x

POOLS=`stratis pool`

# pool1 is not started
if [ ! "`echo $POOLS | grep pool1`" ]; then
  sudo stratis pool start --unlock-method clevis --name pool1
  if [ $? ]; then
    mount /stratis/home;
    if [ $? ]; then
      sudo stratis key unset pool1key
      until sudo stratis key set --capture-key pool1key; do
        echo "try again";
      done
      # sudo stratis pool start --unlock-method keyring --uuid 2304641c-8acc-4bbd-910a-b70d3138d00f
      sudo stratis pool start --unlock-method keyring --name pool1
    fi
  fi
fi

# unneeded:
# -o user_xattr,inline_xattr,acl
# if sudo mount -o defaults,lazytime /dev/stratis/pool1/stratis-home /stratis/home; then
if mount /stratis/home; then
  # bind mount from fstab
  mount $HOME/bin
  echo "Please do:"
  echo ". ~/.bashrc"
else
  echo "$0 failed"
fi

