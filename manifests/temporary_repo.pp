define repoview::temporary_repo ( $output='repoview' ) {

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

  repoview::create_view { "${name}":
    output => $output,
  }

  file { "${path}/repodata":
    ensure  => absent,
    recurse => true,
    force   => true,
  }

  # Create the repodata, generate the HTML pages, and then delete the repodata folder.
 Repoview::Create_view[$name] ~> File["${path}/repodata"]

}
