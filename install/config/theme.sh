# Set links for Nautilius action icons
sudo ln -snf /usr/share/icons/Adwaita/symbolic/actions/go-previous-symbolic.svg /usr/share/icons/Yaru/scalable/actions/go-previous-symbolic.svg
sudo ln -snf /usr/share/icons/Adwaita/symbolic/actions/go-next-symbolic.svg /usr/share/icons/Yaru/scalable/actions/go-next-symbolic.svg

# Setup theme links
mkdir -p ~/.config/collectiveos/themes
for f in ~/.local/share/collectiveos/themes/*; do ln -nfs "$f" ~/.config/collectiveos/themes/; done

# Set initial theme
mkdir -p ~/.config/collectiveos/current
ln -snf ~/.config/collectiveos/themes/collective-os ~/.config/collectiveos/current/theme
ln -snf ~/.config/collectiveos/current/theme/backgrounds/BG1.jpg ~/.config/collectiveos/current/background

# Set specific app links for current theme
# ~/.config/collectiveos/current/theme/neovim.lua -> ~/.config/nvim/lua/plugins/theme.lua is handled via collectiveos-setup-nvim

mkdir -p ~/.config/btop/themes
ln -snf ~/.config/collectiveos/current/theme/btop.theme ~/.config/btop/themes/current.theme

mkdir -p ~/.config/mako
ln -snf ~/.config/collectiveos/current/theme/mako.ini ~/.config/mako/config

# Add managed policy directories for Chromium and Brave for theme changes
sudo mkdir -p /etc/chromium/policies/managed
sudo chmod a+rw /etc/chromium/policies/managed

sudo mkdir -p /etc/brave/policies/managed
sudo chmod a+rw /etc/brave/policies/managed
