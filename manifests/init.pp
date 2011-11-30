# Class: repoview
#
# This module manages repoview
#
# Parameters:
#
#    $basetitle = 'Puppet Labs Yum Repository'
#        Title to be displayed.
#    $basepath = '/var/www/yum'
#        Path to the base yum repository. All other repositories should be in a
#        subdirectory of this one.
#    $temporaryrepos = [ 'main', 'el/5', 'el/6',
#            'fedora/f14', 'fedora/f15', 'fedora/f16', ]
#        Relative paths from $basepath at which to generate a repository view,
#        but at which a yum repository does not already exist. A repository
#        will be created, the HTML pages generated, and then the repository
#        files deleted.
#    $otherrepos = [ 'el/5/products/i386',   'el/5/dependencies/i386',
#            'el/5/products/x86_64', 'el/5/dependencies/x86_64',
#            'el/6/products/i386',   'el/6/dependencies/i386',
#            'el/6/products/x86_64', 'el/6/dependencies/x86_64',
#            'fedora/f14/products/i386',   'fedora/f14/dependencies/i386',
#            'fedora/f14/products/x86_64', 'fedora/f14/dependencies/x86_64',
#            'fedora/f15/products/i386',   'fedora/f15/dependencies/i386',
#            'fedora/f15/products/x86_64', 'fedora/f15/dependencies/x86_64',
#            'fedora/f16/products/i386',   'fedora/f16/dependencies/i386',
#            'fedora/f16/products/x86_64', 'fedora/f16/dependencies/x86_64', ]
#        Relative paths from $basepath at which other repositories exist and
#        should have a view created.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#    To accept the default values given above
#        include repoview
#
#    To change any of the defaults
#        include repoview {
#          $basetitle = 'Acme Yum Repository'
#          $basepath = '/var/www/acme.com/'
#        }
#
# [Remember: No empty lines between comments and class definition]
class repoview ( 
        $basepath='/var/www/yum', 
        $basetitle='Puppet Labs Yum Repository',
        $basetemplates='templates',
        $temporaryrepos=[ 'el/5', 'el/6',
            'fedora/f14', 'fedora/f15', 'fedora/f16', ],
        $otherrepos=[ 'el/5/products/i386',   'el/5/dependencies/i386',
            'el/5/products/x86_64', 'el/5/dependencies/x86_64',
            'el/6/products/i386',   'el/6/dependencies/i386',
            'el/6/products/x86_64', 'el/6/dependencies/x86_64',
            'fedora/f14/products/i386',   'fedora/f14/dependencies/i386',
            'fedora/f14/products/x86_64', 'fedora/f14/dependencies/x86_64',
            'fedora/f15/products/i386',   'fedora/f15/dependencies/i386',
            'fedora/f15/products/x86_64', 'fedora/f15/dependencies/x86_64',
            'fedora/f16/products/i386',   'fedora/f16/dependencies/i386',
            'fedora/f16/products/x86_64', 'fedora/f16/dependencies/x86_64', ]
      ) {

  include repoview::binary

  class { 'repoview::templates':
    path => '/usr/local/share/repoview',
  }

  repoview::temporary_repo { 'main':
    output => '.',
  }

  repoview::temporary_repo { $temporaryrepos: }

  repoview::create_view { $otherrepos: }

}
