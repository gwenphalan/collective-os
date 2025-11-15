source $COLLECTIVEOS_INSTALL/preflight/guard.sh
source $COLLECTIVEOS_INSTALL/preflight/begin.sh
run_logged $COLLECTIVEOS_INSTALL/preflight/show-env.sh
run_logged $COLLECTIVEOS_INSTALL/preflight/pacman.sh
run_logged $COLLECTIVEOS_INSTALL/preflight/migrations.sh
run_logged $COLLECTIVEOS_INSTALL/preflight/first-run-mode.sh
run_logged $COLLECTIVEOS_INSTALL/preflight/disable-mkinitcpio.sh
