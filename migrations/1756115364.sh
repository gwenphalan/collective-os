echo "Replace buggy native Zoom client with webapp"

if collectiveos-pkg-present zoom; then
  collectiveos-pkg-drop zoom
  collectiveos-webapp-install "Zoom" https://app.zoom.us/wc/home https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/zoom.png
fi
