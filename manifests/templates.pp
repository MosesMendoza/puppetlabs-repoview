class repoview::templates ( $path='/usr/share/repoview' ) {

  file { $path:
    ensure => directory,
  }

  file { "${path}/templates":
    source  => "puppet:///modules/repoview/templates",
    ensure  => directory,
    recurse => true,
  }

}
