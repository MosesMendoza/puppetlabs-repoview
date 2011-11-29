# Manage the repoview binary manually. A repoview package does not exist for
# Debian, and the binary has been patched to enable the output-dir option
# (which is unlikely to be merged upstream).
class repoview::binary {

  include repoview::binary::dependencies

  file { '/usr/local/bin/repoview':
    ensure  => present,
    source  => 'puppet:///modules/repoview/repoview.py',
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    require => Class['repoview::binary::dependencies'],
  }
  
}
