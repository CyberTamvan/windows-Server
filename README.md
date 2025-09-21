# 🚀 Panduan Instalasi Windows Server via QEMU

## 📥 Langkah-langkah Instalasi

### 1️⃣ Unduh dan Instal File Installer
Jalankan perintah berikut untuk mengunduh installer:

```bash
wget https://raw.githubusercontent.com/CyberTamvan/windows-Server/refs/heads/main/installer.sh
```

### 2️⃣ Berikan Izin Eksekusi pada File
Setelah diunduh, ubah permission agar file bisa dijalankan:

```bash
chmod +x installer.sh
```

### 3️⃣ Jalankan Installer
Eksekusi installer:

```bash
./installer.sh
```

### 4️⃣ Jalankan QEMU
Setelah proses instalasi selesai, jalankan QEMU untuk memulai Windows Server.  
Ganti `xx` dengan versi Windows yang dipilih (contoh: `windows10`):

```bash
qemu-system-x86_64 -m 4G -cpu host -enable-kvm -boot order=d -drive file=windowsxx.iso,media=cdrom -drive file=windowsxx.img,format=raw,if=virtio -drive file=virtio-win.iso,media=cdrom -device usb-ehci,id=usb,bus=pci.0,addr=0x4 -device usb-tablet -vnc :0
```

> ⚠️ **Catatan:** Tekan **Enter dua kali** untuk melanjutkan.

### 5️⃣ Akses via VNC
Setelah QEMU berjalan, lakukan konfigurasi di Windows Server:
- ✅ Aktifkan **Remote Desktop**
- ❌ Nonaktifkan **CTRL+ALT+DEL** di Local Security
- 🔋 Atur agar Windows **tidak pernah sleep**

---

## 📦 Kompres & Distribusi File Windows Server

### 6️⃣ Kompres File Windows Server
Ganti `xxxx` dengan versi Windows (contoh: `windows10`):

```bash
dd if=windowsxxxx.img | gzip -c > windowsxxxx.gz
```

### 7️⃣ Instal Apache
Gunakan perintah berikut:

```bash
apt install apache2 -y
```

### 8️⃣ Berikan Akses Firewall
Izinkan Apache di firewall:

```bash
sudo ufw allow 'Apache'
```

### 9️⃣ Pindahkan File ke Direktori Web
Salin hasil kompresi ke folder Apache:

```bash
cp windowsxxxx.gz /var/www/html/
```

### 🔗 10. Link Download
Akses file melalui IP droplet Anda:

```
http://[IP_Droplet]/windowsxxxx.gz
```

**Contoh:**
```
http://188.166.190.241/windows10.gz
```

---

## 🌐 Menjalankan Windows Server di Droplet Baru
Gunakan perintah berikut (ganti `LINK` dengan URL file Anda):

```bash
wget -O- --no-check-certificate LINK | gunzip | dd of=/dev/vda
```

---

## ☁️ Upload File Windows ke Google Drive

Perintah ini menggunakan **rclone**. Pastikan sudah diinstal dan dikonfigurasi.

### 🔍 Cek Isi Folder
```bash
ls -l /var/www/html/winser/
```

### 📤 Upload ke Gdrive
```bash
rclone copy /var/www/html/winser/windows2019.gz gdrive: --progress
```

---

## ⚠️ Catatan Penting
- Pastikan mengganti **`xxxx`** dengan versi Windows yang sesuai.
- Ganti **`LINK`** dengan URL file hasil kompresi Anda.
- Jangan lupa mengaktifkan **rclone config** sebelum upload ke Google Drive.
