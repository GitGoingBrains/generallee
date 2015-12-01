#!/bin/bash
# final steps to automated setup (reboot should be the very end)
#fetch private tokens/keys
#create tmux sessions setup and autosave
#rm setup scripts etc.
echo "step99.sh succes, reboot comencing..." >> setup-args.log
shutdown -r now
