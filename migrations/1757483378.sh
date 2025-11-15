echo "6Ghz Wi-Fi + Intel graphics acceleration for existing installations"

bash "$COLLECTIVEOS_PATH/install/config/hardware/set-wireless-regdom.sh"
bash "$COLLECTIVEOS_PATH/install/config/hardware/intel.sh"
