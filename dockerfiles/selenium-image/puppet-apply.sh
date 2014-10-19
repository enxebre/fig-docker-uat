#/bin/bash
puppet apply --confdir=/etc/puppet --modulepath='$confdir/modules:$confdir/modules/puppetforge-modules' --detailed-exitcodes --debug --verbose -e "include uat_environment"
RETVAL=$?
if [ "$RETVAL" = 0 ] || [ "$RETVAL" = 2 ] ; then
  exit 0
fi

exit 1
