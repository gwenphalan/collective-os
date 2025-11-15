echo "Change to collectiveos-nvim package"
collectiveos-pkg-drop collectiveos-lazyvim
collectiveos-pkg-add collectiveos-nvim

# Will trigger to overwrite configs or not to pickup new hot-reload themes
collectiveos-nvim-setup
