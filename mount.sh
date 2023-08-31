#!/bin/bash

# Function to check if a mount point or file system is mounted
check_mount_status() {
    mount_point=$1
    if grep -qs "$mount_point " /proc/mounts; then
        df -hT "$mount_point" | awk 'NR==2 {print "Used Space:", $3, "Free Space:", $5}'
    else
        read -p "The file system is not mounted. Do you want to attempt to mount it? (y/n): " choice
        if [ "$choice" == "y" ]; then
            mount "$mount_point"
            df -hT "$mount_point" | awk 'NR==2 {print "Used Space:", $3, "Free Space:", $5}'
        else
            echo "File system is not mounted."
        fi
    fi
}

# Prompt the user for a mount point or file system
read -p "Enter the mount point or file system: " input_mount

# Call the function with the provided input
check_mount_status "$input_mount"
