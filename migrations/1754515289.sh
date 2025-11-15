echo "Update and restart Walker to resolve stuck CollectiveOS menu"

sudo pacman -Syu --noconfirm walker-bin
collectiveos-restart-walker
