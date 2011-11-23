<?xml version="1.0" encoding="utf-8"?>
<?python
import time, os

def ymd(stamp):
    return time.strftime('%Y-%m-%d', time.localtime(int(stamp)))

def html_time(stamp):
    tz = time.timezone
    td = (lambda:"-", lambda:"+")[tz < 0]()  # a ternery operator
    tz = time.strftime('%H:%M', time.gmtime(abs(tz)))
    t  = time.strftime('%Y-%m-%dT%H:%M:%S', time.localtime(int(stamp)))
    return "%s%s%s" % (t, td, tz)

def get_platform_name(title):
    return title.split('-')[1].strip()

def get_platform_family(title):
    name = get_platform_name(title)
    if (name == "Enterprise Linux"): return "el"
    if (name == "Fedora"): return "fedora"

def get_platform_version(title):
    return title.split('-')[2].strip()

def get_platform_arch(title):
    return title.split('-')[3].strip()
?>
<html xmlns:py="http://purl.org/kid/ns#" dir="ltr" lang="en-US">
<?python
# repo_data only exists within <html> another reason to hate repoview
PLATFORM_NAME=get_platform_name(repo_data['title'])
PLATFORM_FAMILY=get_platform_family(repo_data['title'])
PLATFORM_VERSION=get_platform_version(repo_data['title'])
PLATFORM_ARCH=get_platform_arch(repo_data['title'])
?>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title py:content="repo_data['title']"></title>
  <link py:if="url is not None"
    rel="alternate" type="application/rss+xml" title="RSS" href="latest-feed.xml" />
  <link rel="stylesheet" href="layout/style.css" type="text/css" />
</head>
<body>

  <header id="header">
    <section class="site-width">
      <h1 id="logo">
        <a href="http://puppetlabs.com/"><img src="layout/images/puppet-labs.png" /></a>
      </h1>
      <h2>Puppet Labs Yum Repository</h2>
      <nav id="letter-nav">Jump to letter: [
        <a class="letter" py:for="letter in repo_data['letters']" href="${'letter_%s.group.html' % letter.lower()}" py:content="letter" />
        ]
      </nav>
    </section>
  </header>

  <section id="masthead">
    <section class="site-width">
      <h1 py:content="'%s %s - %s - Dependencies' % ( PLATFORM_NAME
                                                    , PLATFORM_VERSION
                                                    , PLATFORM_ARCH)" />
    </section>
  </section>

  <section id="content">
    <section class="site-width">

      <div id="description">

        <p> This repository contains the more specialized dependencies that
          Puppet's products require. The Puppet Labs <a
            href="../../products/${PLATFORM_ARCH}/">Products repository</a>
          contains the packages released by Puppet Labs.  </p>

        <p> The Puppet Labs repositories can be added by running

          <code># rpm -Uvh http://yum.puppetlabs.com/${PLATFORM_FAMILY}/${PLATFORM_VERSION}/products/${PLATFORM_ARCH}/puppetlabs-release-${PLATFORM_VERSION}-1.noarch.rpm</code>
        </p>

      </div>

      <section id="group-list">
        <h2>Available Groups</h2>
        <ul class="pkglist">
          <li py:for="(name, filename, description, packages) in groups">
            <a href="${filename}" py:content="name" />
          </li>
        </ul>
      </section>

      <section id="package-list">
        <h2>Latest Packages</h2>
        <ul class="pkglist">
          <li py:for="(name, filename, version, release, built) in latest">
            <time datetime="${html_time(built)}" py:content="ymd(built)" />
            <a href="${filename}" py:content="'%s-%s-%s' % (name, version, release)" />
          </li>
        </ul>
      </section>
    </section>
  </section>

  <footer id="footer">
    <section class="site-width">
      <section id="generation">
        <?python n = time.time() ?>
        Generated <time datetime="${html_time(n)}" py:content="ymd(n)" />
        by <a href="https://fedorahosted.org/repoview/" py:content="'RepoView-%s' % repo_data['my_version']"/>
      </section>

      <section id="copyright">
        &copy; 2011 Puppet Labs •
        <a href="mailto:info@puppetlabs.com">info@puppetlabs.com</a> •
        411 NW Park / Portland, OR 97209 •
        1-877-575-9775
      </section>
    </section>
  </footer>

</body>
</html>

<?python # vim: set expandtab sw=2 ts=2 sts=2 : ?>
