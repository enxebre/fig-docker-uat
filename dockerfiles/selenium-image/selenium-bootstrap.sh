/etc/init.d/xvfb restart
/etc/init.d/x11vnc restart
/etc/init.d/seleniumhub restart
# Giving enough time to the hub for running up.
sleep 3
/etc/init.d/seleniumnode restart
tail -f /var/log/selenium/node_stderr.log
