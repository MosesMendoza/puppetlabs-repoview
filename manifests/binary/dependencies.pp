class repoview::binary::dependencies {

  package { 'python-kid':
    ensure => present,
  }

  package { 'yum':
    ensure => present,
  }

  package { 'createrepo':
    ensure => present,
  }

}
