echo "Change to openai-codex instead of openai-codex-bin"

if collectiveos-pkg-present openai-codex-bin; then
    collectiveos-pkg-drop openai-codex-bin
    collectiveos-pkg-add openai-codex
fi
