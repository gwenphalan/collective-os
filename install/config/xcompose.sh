# Set default XCompose that is triggered with CapsLock
tee ~/.XCompose >/dev/null <<EOF
include "%H/.local/share/collectiveos/default/xcompose"

# Identification
<Multi_key> <space> <n> : "$COLLECTIVEOS_USER_NAME"
<Multi_key> <space> <e> : "$COLLECTIVEOS_USER_EMAIL"
EOF
