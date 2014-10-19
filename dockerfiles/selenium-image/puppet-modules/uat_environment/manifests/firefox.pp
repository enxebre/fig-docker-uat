# = Class: uat_environment::firefrox
#
# Creates mozilla tree folder for a given user.
# Download, uncompress, givve right permissions and remove a firefox.tar file.
# Creates a Firefox profile file.
#
class uat_environment::firefox(
  $firefox_version = $uat_environment::params::firefox_version,
  $firefox_folder  = $uat_environment::params::firefox_folder,
  $user            = $uat_environment::params::user,
  $proxyuri        = hiera('proxy_config::proxyuri', $uat_environment::params::proxyuri),
) inherits uat_environment::params {

  $protocol_uri_array = split($proxyuri, '//')
  $host_port_array = split($protocol_uri_array[1], ':')
  $proxy_ip = $host_port_array[0]
  $proxy_port = $host_port_array[1]

  # Creating mozilla tree folder for selenium user.
  file { "/home/${user}":
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => '0750',
  }
  ->
  file { "/home/${user}/.mozilla":
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => '0750',
  }
  ->
  file { "/home/${user}/.mozilla/firefox":
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => '0750',
  }
  ->
  file { "/home/${user}/.mozilla/firefox/profiles.ini":
    source => 'puppet:///modules/uat_environment/mozilla/profiles.init',
  }
  ->
  file { "/home/${user}/.mozilla/firefox/customprofile.behat":
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => '0750',
  }
  ->
  file { "/home/${user}/.mozilla/firefox/customprofile.behat/prefs.js":
    content => template('uat_environment/mozilla/prefs.js.erb'),
    notify  => Service['seleniumnode'],
  }

  # Downloading, uncompressing, giving right permissions and removing firefox.tar file.
  wget::fetch { $firefox_version:
    source      => "http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/17.0/linux-x86_64/en-GB/${$firefox_version}.tar.bz2",
    destination => "${firefox_folder}${firefox_version}.tar.bz2",
    timeout     => 200,
  }

  exec { "uncompress-${firefox_version}":
    command => "tar xjvf ${firefox_folder}${firefox_version}.tar.bz2;chmod 755 ${firefox_folder}firefox -R;",
    path    => [ '/bin/', '/usr/bin/' ],
    cwd     => $firefox_folder,
    require => Wget::Fetch[$firefox_version],
    user    => 'root'
  }
}
