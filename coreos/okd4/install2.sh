# https://stackoverflow.com/questions/1167746/how-to-assign-a-heredoc-value-to-a-variable-in-bash
read -r -d '' IGNITION <<'EOF'
-fw_cfg name=opt/com.coreos/config,string={
  "ignition": {
    "config": {
      "replace": {
        "source": null,
        "verification": {}
      }
    },
    "security": {
      "tls": {}
    },
    "timeouts": {},
    "version": "3.0.0"
  },
  "passwd": {
    "users": [
      {
        "name": "core",
        "passwordHash": "$6$sk8W$GyFsy5z0g51.4Z0AzMX9rQY1Jyep5Q43q1yKGR3kQGxWlejat6ITgA6azd2Z/eZ8MG38gkmk3gQXz912MBGrs0",
        "sshAuthorizedKeys": [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHQb6Th6D/3IOdjPKgYzOI/TkQuwd4SLxFu3wmcMVcOd tpasch@linux.fritz.box",
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5NSD1wNDCbz6348KE/QdljNI8J2QuPZqBYgJBEFasWoKHBkaGcmurv6J+9HaIMzN11dU267f43j0kKW/WNotDLi7BDLka2PKamcDyCAWI1pr9R7QsZuCmUWrm+QNAYLWICr/e2kE198xp/Up/lTlCr0M5eUlsJULYf06PRInedOfk7D0O3rNMhVy3grZF5muMXfnYr0exVaMPQt+iVVPV+uAsY0u/io728j63Ebsl1uGkK6BswB5/J8RiWOBRpxZugQ3dYRz4aZAHJL42BbdtjbLfr9d8HMGQuO6r2b+OvkTWTONNS8sHGrMsSVb8rRL0y2m4/JwkLTJ0Zq2Rb1IYOC30Ibc4KW9d/FwviOIeGG+us27/d4KHYT5vweNKL7ADAsyQm/A/1IEAg9g4sDExJ1Oy+OKCL+XHxmMFV8WFdo4n3gJdcU2qLfz/RVK1ARUBcWYL0coBb2+CPXP54OOAuR2pQ7kwMLAyykQPKyE5q1OOVEd3il/u8q0CsACebeY9fO4WrS5PEXLNivxOal7m/pAgWfGeIdOouzZPsoRiplD6q9K3TJ59GbGEFnPfjSp5fnUePnPTHXdkf37c5RhbQetnSuq3rneHt9feEhFz1pPs5Ta91WkQjIn/eg8eeevpYmvjnG6XRzwWyVXe5YCbvyF/BW5JVWmR0yarjowmsQ== tpasch@node1"
        ]
      },
      {
        "name": "tpasch",
        "passwordHash": "$6$skjWSkjs982kj2$yrsYzN1AArd06/46ZKIHIkeinGl2olsSTb41k7LNENMIywVHePcVCzgSe/flXhgHj7uY/rZgqgLzgx0Ob7vVq/",
        "sshAuthorizedKeys": [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHQb6Th6D/3IOdjPKgYzOI/TkQuwd4SLxFu3wmcMVcOd tpasch@linux.fritz.box",
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5NSD1wNDCbz6348KE/QdljNI8J2QuPZqBYgJBEFasWoKHBkaGcmurv6J+9HaIMzN11dU267f43j0kKW/WNotDLi7BDLka2PKamcDyCAWI1pr9R7QsZuCmUWrm+QNAYLWICr/e2kE198xp/Up/lTlCr0M5eUlsJULYf06PRInedOfk7D0O3rNMhVy3grZF5muMXfnYr0exVaMPQt+iVVPV+uAsY0u/io728j63Ebsl1uGkK6BswB5/J8RiWOBRpxZugQ3dYRz4aZAHJL42BbdtjbLfr9d8HMGQuO6r2b+OvkTWTONNS8sHGrMsSVb8rRL0y2m4/JwkLTJ0Zq2Rb1IYOC30Ibc4KW9d/FwviOIeGG+us27/d4KHYT5vweNKL7ADAsyQm/A/1IEAg9g4sDExJ1Oy+OKCL+XHxmMFV8WFdo4n3gJdcU2qLfz/RVK1ARUBcWYL0coBb2+CPXP54OOAuR2pQ7kwMLAyykQPKyE5q1OOVEd3il/u8q0CsACebeY9fO4WrS5PEXLNivxOal7m/pAgWfGeIdOouzZPsoRiplD6q9K3TJ59GbGEFnPfjSp5fnUePnPTHXdkf37c5RhbQetnSuq3rneHt9feEhFz1pPs5Ta91WkQjIn/eg8eeevpYmvjnG6XRzwWyVXe5YCbvyF/BW5JVWmR0yarjowmsQ== tpasch@node1"
        ]
      }
    ]
  },
  "storage": {},
  "systemd": {
    "units": [
      {
        "dropins": [
          {
            "contents": "[Service]\nEnvironment=OPTIONS='-oPasswordAuthentication=yes'\n",
            "name": "allowpasswordauth.conf"
          }
        ],
        "name": "sshd.service"
      }
    ]
  }
}
EOF

declare -p IGNITION

virt-install --connect qemu:///system -n fcos -r 8196 --os-variant=fedora31 --qemu-commandline='"'"$IGNITION"'"' --import --graphics=none --disk size=10,backing_store=/mnt/home/tpasch/Downloads/okd4/f31core.qcow2 --network network=default
