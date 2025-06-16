#!/bin/bash

# ────────────────────────────────
# 🧪 Linux Mint Postinstall Script
# Bleak Mirror Edition — por Martín
# ────────────────────────────────

set -e

echo "🧼 Actualizando sistema..."
sudo apt update && sudo apt upgrade -y

echo "🔧 Instalando herramientas esenciales..."
sudo apt install -y curl wget git net-tools htop neofetch unzip build-essential

echo "🐍 Instalando Python y pip..."
sudo apt install -y python3 python3-pip

echo "🟢 Instalando Node.js + npm..."
sudo apt install -y nodejs npm

echo "🧅 Instalando Tor..."
sudo apt install -y tor
sudo systemctl enable tor
sudo systemctl start tor

echo "🧲 Instalando IPFS (go-ipfs)..."
cd /tmp
wget https://dist.ipfs.io/go-ipfs/v0.25.0/go-ipfs_v0.25.0_linux-amd64.tar.gz
tar -xvzf go-ipfs_v0.25.0_linux-amd64.tar.gz
cd go-ipfs
sudo bash install.sh
cd ~
ipfs init || true

echo "👻 Instalando I2P..."
sudo apt install -y i2p
echo "Podés correrlo con: i2prouter start"

echo "🎨 Aplicando estilo oscuro (opcional)..."
xfconf-query -c xsettings -p /Net/ThemeName -s 'Mint-Y-Dark'
xfconf-query -c xsettings -p /Gtk/FontName -s 'Hack 10'

echo "🧪 Creando menú de servicios..."

cat << 'EOF' > ~/bleakmirror.sh
#!/bin/bash
while true; do
  clear
  echo "🧪 Bleak Mirror - Centro de Control"
  echo "1) Iniciar Tor"
  echo "2) Iniciar IPFS"
  echo "3) Iniciar I2P"
  echo "4) Salir"
  read -p "Seleccioná una opción: " opc
  case $opc in
    1) sudo systemctl start tor && echo "Tor iniciado";;
    2) ipfs daemon & disown && echo "IPFS iniciado";;
    3) i2prouter start && echo "I2P iniciado";;
    4) exit;;
    *) echo "Opción inválida";;
  esac
  read -p "Presioná Enter para continuar..."
done
EOF

chmod +x ~/bleakmirror.sh
echo "✅ Script listo. Podés correrlo con: ~/bleakmirror.sh"

echo "🎉 ¡Sistema listo para navegar el inframundo digital, maestro!"
neofetch
