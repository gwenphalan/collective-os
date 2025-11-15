echo "Change collectiveos-screenrecord to use gpu-screen-recorder"
collectiveos-pkg-drop wf-recorder wl-screenrec

# Add slurp in case it hadn't been picked up from an old migration
collectiveos-pkg-add slurp gpu-screen-recorder
