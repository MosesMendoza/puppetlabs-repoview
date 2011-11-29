define repoview::create_view ( $output='.' ) {

  if $name == "main" {
    $path = $basepath
    $repotitle = $basetitle
    $templates = "${basetemplates}/main"
  } else {
    $path = "${basepath}/${name}"

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

    case $name {
      /(products|dependencies)\/(i386|x86_64|SRPMS)/: {
        $templates = "${basetemplates}/specific/${1}"
        $repotitle = "${basetitle} - ${platform} - ${version} - ${2}"
      }
      default: {
        $templates = "${basetemplates}/specific/platform"
        $repotitle = "${basetitle} - ${platform} - ${version}"
      }
    }
  }

  exec { "repoview ${path}":
    command  => "repoview --template-dir='${templates}' --title='${repotitle}' --output-dir='${output}' ${path}",
    path     => '/usr/local/bin',
    cwd      => "/usr/local/share/repoview",
    require => [ Class['repoview::templates'], Class['repoview::binary'] ],
  }

}
