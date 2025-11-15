echo "Add UWSM env"

export COLLECTIVEOS_PATH="$HOME/.local/share/collectiveos"
export PATH="$COLLECTIVEOS_PATH/bin:$PATH"

mkdir -p "$HOME/.config/uwsm/"
cat <<EOF | tee "$HOME/.config/uwsm/env"
export COLLECTIVEOS_PATH=$HOME/.local/share/collectiveos
export PATH=$COLLECTIVEOS_PATH/bin/:$PATH
EOF

mkdir -p ~/.local/state/collectiveos/migrations
touch ~/.local/state/collectiveos/migrations/1751134560.sh

sudo systemctl restart systemd-timesyncd
bash collectiveos-update-perform
