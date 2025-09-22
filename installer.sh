#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Windows Server or Windows version:"
    echo "1. Windows Server 2016"
    echo "2. Windows Server 2019"
    echo "3. Windows Server 2022"
    echo "4. Windows 10"
    echo "5. Windows 11"
    echo "6. Windows Server 2025"
    read -p "Enter your choice: " choice
}

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install QEMU and its utilities
apt-get install qemu -y
apt install qemu-utils -y
apt install qemu-system-x86-xen -y
apt install qemu-system-x86 -y
apt install qemu-kvm -y

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
        iso_link="https://software.download.prss.microsoft.com/dbazure/Win10_22H2_English_x64v1.iso?t=ef814510-2505-462f-aefd-82805d096bec&P1=1758630552&P2=601&P3=2&P4=xLxpCP2zwEbXCv55UpF3ziQKVMLRjptQ6DuqsCLoFkxi6dBYtinQ5TiUwkNJNN8aTSil65F4w872cZoKwsrZYCQHPyZdEsvjRkEfOe2jt4IyU0w7oJaN0B2nn8KFPlwwr1f2FKEXyfF20UZ6EMaYO%2fpLZ%2bwpjJ2VJ9Fg92SLSsJasUSxbLvmIOvY6INwPPbGsSj1tPs%2fE5nfhr0S4Cd5rTDBPQ49kZruXgtJ%2beZO5lUhe22BVu5SY1%2bH2KoQ39MStoX142xXVgaookec5n%2b%2b8Pc1tVOZy5iOcJdBocuxFhyHutopXM2QPPQIFxHZpCrzgJd7QjC5Ks1aDQbLpIkrkw%3d%3d"
        iso_file="windows10.iso"
        ;;
    5)
        img_file="windows11.img"
        iso_link="https://software.download.prss.microsoft.com/dbazure/Win11_24H2_English_x64.iso?t=934cce49-e1ae-4145-9091-aca6d0a1255e&P1=1758632595&P2=601&P3=2&P4=oTf0E6uXRa12LlZtWNCG5393AIqrkSOyhQglk4H7aPdASl8JDQM70DR898H02e1P2l5wpGSJKcp0ZkHKXQAFO0%2fVLaxQXCqgpDMsNTUEPL0rSw%2fa4NIUrLm9NRn5NNWXXHQvzEReHIA%2bhB88cVyC2FA%2bCS%2bXhaUfoyGgVD1lobltD7AxbnY3QAYgkJIPTav0JMtovF1pt5DKOJRpeZD0E9TtUM2Wm17u5hJSCvMnlmppEmrGQa3b5qLI3gjg%2f840ivSczEgJM3Zec2YAlS8ZDR2IaLvZKOAxhtsEhcz2U3VwxIgJZExN9RRQn1uaLupdJzzsB2j%2b9Y%2fptPCZRhCsdQ%3d%3d"
        iso_file="windows11.iso"
        ;;
    6)
        img_file="windows2025.img"
        iso_link="https://dl.bobpony.com/windows/server/2025/en-us_windows_server_2025_updated_april_2025_x64_dvd_ea86301d.iso"
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
