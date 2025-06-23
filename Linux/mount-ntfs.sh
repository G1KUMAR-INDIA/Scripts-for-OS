#!/bin/bash

# Script to mount an NTFS partition in Ubuntu

# 1. Set variables
PARTITION="/dev/sdb"     # Replace with your actual NTFS partition (e.g., /dev/sda3)
MOUNT_POINT="/mnt/ntfs"

# 2. Ensure ntfs-3g is installed
echo "Installing NTFS support..."
sudo apt update
sudo apt install -y ntfs-3g

# 3. Create mount point if it doesn't exist
if [ ! -d "$MOUNT_POINT" ]; then
    echo "Creating mount point at $MOUNT_POINT"
    sudo mkdir -p "$MOUNT_POINT"
fi

# 4. Mount the NTFS partition
echo "Mounting $PARTITION to $MOUNT_POINT..."
sudo mount -t ntfs-3g "$PARTITION" "$MOUNT_POINT"

# 5. Check mount success
if mount | grep "$MOUNT_POINT" > /dev/null; then
    echo "✅ NTFS partition mounted successfully at $MOUNT_POINT"
else
    echo "❌ Failed to mount NTFS partition. Please check the partition name and try again."
fi
