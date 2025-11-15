# Show installation environment variables
gum log --level info "Installation Environment:"

env | grep -E "^(COLLECTIVEOS_CHROOT_INSTALL|COLLECTIVEOS_ONLINE_INSTALL|COLLECTIVEOS_USER_NAME|COLLECTIVEOS_USER_EMAIL|USER|HOME|COLLECTIVEOS_REPO|COLLECTIVEOS_REF|COLLECTIVEOS_PATH)=" | sort | while IFS= read -r var; do
  gum log --level info "  $var"
done
