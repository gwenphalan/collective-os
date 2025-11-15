# Set identification from install inputs
if [[ -n "${COLLECTIVEOS_USER_NAME//[[:space:]]/}" ]]; then
  git config --global user.name "$COLLECTIVEOS_USER_NAME"
fi

if [[ -n "${COLLECTIVEOS_USER_EMAIL//[[:space:]]/}" ]]; then
  git config --global user.email "$COLLECTIVEOS_USER_EMAIL"
fi
