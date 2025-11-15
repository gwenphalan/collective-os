COLLECTIVEOS_MIGRATIONS_STATE_PATH=~/.local/state/collectiveos/migrations
mkdir -p $COLLECTIVEOS_MIGRATIONS_STATE_PATH

for file in ~/.local/share/collectiveos/migrations/*.sh; do
  touch "$COLLECTIVEOS_MIGRATIONS_STATE_PATH/$(basename "$file")"
done
