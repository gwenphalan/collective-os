echo "Copy CollectiveOS logo to ~/.config/collectiveos/branding/screensaver.txt so screensaver can be personalized"

mkdir -p ~/.config/collectiveos/branding
cp $COLLECTIVEOS_PATH/logo.txt ~/.config/collectiveos/branding/screensaver.txt
