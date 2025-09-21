#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Windows Server or Windows version:"
    echo "1. Windows Server 2016"
    echo "2. Windows Server 2019"
    echo "3. Windows Server 2022"
    echo "4. Windows 10"
    echo "5. Windows 11"
    echo "6. Windows 1021h2"
    echo "7. Windows Server 2025"
    read -p "Enter your choice: " choice
}

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install QEMU and its utilities
apt-get install -y qemu qemu-utils qemu-system-x86-xen qemu-system-x86 qemu-kvm

echo "QEMU installation completed successfully."

# Get user choice
display_menu

case $choice in
    1)
        img_file="windows2016.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195174&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2016.iso"
        ;;
    2)
        img_file="windows2019.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195167&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2019.iso"
        ;;
    3)
        img_file="windows2022.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195280&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2022.iso"
        ;;
    4)
        img_file="windows10.img"
        iso_link="http://167.172.161.184/WIN10.ISO"
        iso_file="windows10.iso"
        ;;
    5)
        img_file="windows11.img"
        iso_link="http://167.172.161.184/WIN11.ISO"
        iso_file="windows11.iso"
        ;;
    6)
        img_file="windows1021h2.img"
        iso_link="http://167.172.161.184/win1021H2.img"
        iso_file="windows1021h2.iso"
        ;;
    7)
        img_file="windows2025.img"
        iso_link="https://drive.massgrave.dev/en-us_windows_server_2025_updated_sep_2025_x64_dvd_6d1ad20d.iso"
        iso_file="windows2025.iso"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected version: $img_file"

# Create a raw image file with the chosen name
qemu-img create -f raw "$img_file" 120G

echo "Image file $img_file created successfully."

# Download Virtio driver ISO (updated link)
wget -O virtio-win.iso 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.285-1/virtio-win.iso'

echo "Virtio driver ISO downloaded successfully."

# Download Windows ISO with the chosen name
wget -O "$iso_file" "$iso_link"

echo "Windows ISO downloaded successfully."
