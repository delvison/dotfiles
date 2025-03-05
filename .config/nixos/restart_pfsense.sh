#!/usr/bin/env bash

# Info: sometimes, pfsense fails to get a WAN IP. This script is meant to run in a cron. It checks if there is internet connectivity. If there is not, it will restart the pfsense VM.

check_internet() {
    if ping -c 1 torproject.org &> /dev/null; then
        return 0
    else
        return 1
    fi
}

reboot_pfsense() {
    VM_ID=$(qm list | grep pfsense | head -n1 | awk '{print $1}')
    qm reboot ${VM_ID}
    echo "Rebooting VM $VM_ID"
}

for i in {1..3}; do
    if ! check_internet; then
        echo "Attempt $i faled. Checking again..."
    else
        echo "Internet connection detected. Exiting."
        exit 0
    fi
    sleep 30
done

echo "All attempts failed"
reboot_pfsense
