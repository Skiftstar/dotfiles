#!/bin/bash

sudo chmod a+wr /opt/spotify &&
sudo chmod a+wr /opt/spotify/Apps -R &&
sudo chmod a+wr /usr/share/spicetify-cli/ -R &&
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh &&
spicetify backup apply
