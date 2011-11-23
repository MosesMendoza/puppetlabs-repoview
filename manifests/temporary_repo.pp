define repoview::temporary_repo ( $output='.' ) {

  if $name == "main" {
    $path = $basepath
  } else {
    case $name {
      /^el\/([0-9]+)/: {
        $platform = "Enterprise Linux"
        $version = $1
      }
      /^fedora\/f([0-9]+)/: {
        $platform = "Fedora"
        $version = $1
      }
    }

    $path = "${basepath}/${name}"
  }

  exec { "createrepo -d ${path}":
    path    => '/usr/bin',
    require => Package['createrepo'],
  }

  repoview::create_view { "${name}":
    output => $output,
  }

  file { "${path}/repodata":
    ensure  => absent,
    recurse => true,
    force   => true,
  }

  # Create the repodata, generate the HTML pages, and then delete the repodata folder.
  Exec["createrepo -d ${path}"] -> Repoview::Create_view[$name] ~> File["${path}/repodata"]

}
