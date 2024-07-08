# Enable Bluetooth
sudo systemctl enable bluetooth &&
sudo systemctl start bluetooth &&

# Spicetify setup
sudo chmod a+wr /opt/spotify &&
sudo chmod a+wr /opt/spotify/Apps -R &&
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh &&
spicetify backup apply &&

# Remove Genshin Telemetry
echo "0.0.0.0 log-upload-os.hoyoverse.com
0.0.0.0 overseauspider.yuanshen.com" | sudo tee -a /etc/hosts