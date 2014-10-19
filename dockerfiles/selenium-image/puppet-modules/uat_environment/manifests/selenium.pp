# = uat_environment::selenium
#
# Initiates Selenium grid with one node.
# You should be able to access from http://localhost:4444/grid
# and to access to a remote display service here http://localhost:5900
#
class uat_environment::selenium (
  $firefox_version = $uat_environment::params::firefox_version,
  $firefox_folder  = $uat_environment::params::firefox_folder,
  $java_version    = '1.7.0',
) inherits uat_environment::params {

  # Running Selenium grid with one node.
  package { ["java-${java_version}-openjdk", "java-${java_version}-openjdk-devel"]:
    ensure => present,
  }
  ->
  class { 'display':
    width  => 1680,
    height => 1050,
  }
  ->
  class { 'selenium::hub': 
    options => '-role hub -port ${SELENIUM_PORT}',
  }

  class { 'selenium::node':
    options => "-role node -Dwebdriver.enable.native.events=1 -Dwebdriver.firefox.bin=${firefox_folder}firefox/firefox -Dwebdriver.firefox.profile=behat -browser browserName=firefox,maxInstances=5 -trustAllSSLCertificates \"*firefox ${firefox_folder}firefox/firefox\"",
    hub    => 'http://localhost:${SELENIUM_PORT}/grid/register',
    require => Exec["uncompress-${firefox_version}"],
  }
}
