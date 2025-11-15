# Copy over CollectiveOS configs
mkdir -p ~/.config
cp -R ~/.local/share/collectiveos/config/* ~/.config/

# Use default bashrc from CollectiveOS
cp ~/.local/share/collectiveos/default/bashrc ~/.bashrc
