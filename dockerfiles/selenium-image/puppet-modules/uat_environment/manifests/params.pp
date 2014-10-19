# = Class: uat_environment::params
#
# Params for firefox behat environment
#
class uat_environment::params {
  $firefox_version = 'firefox-17.0'
  $firefox_folder  = '/opt/'
  $user            = 'selenium'
  $proxyuri        = ''
}
