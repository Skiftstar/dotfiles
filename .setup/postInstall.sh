sudo systemctl enable bluetooth &&
sudo systemctl start bluetooth &&

sudo chmod a+wr /opt/spotify &&
sudo chmod a+wr /opt/spotify/Apps -R &&
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh