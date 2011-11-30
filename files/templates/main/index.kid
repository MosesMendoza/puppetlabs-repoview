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
?>
<html xmlns:py="http://purl.org/kid/ns#" dir="ltr" lang="en-US">
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
      <nav id="letter-nav">Jump to letter: [
        <a class="letter" py:for="letter in repo_data['letters']" href="${'letter_%s.group.html' % letter.lower()}" py:content="letter" />
        ]
      </nav>
    </section>
  </header>

  <section id="masthead">
    <section class="site-width">
      <h1 py:content="repo_data['title']">Puppet Labs Yum Repository</h1>
    </section>
  </section>

  <section id="content">
    <section class="site-width">

      <div id="description">

        <p> The Puppet Labs Yum Repository contains packages for software
          released by Puppet Labs. This is the main yum repository which
          contains packages for all the supported distributions. Please see
          below for platform specific repoistories. </p>

        <section id="platforms">
          <h2>Platforms</h2>

          <h3>Enterprise Linux &ndash; RedHat, CentOS, Scientific</h3>
          <ul class="platform-list">
            <li><a href="el/6/repoview">EL 6</a></li>
            <li><a href="el/5/repoview">EL 5</a></li>
          </ul>

          <h3>Fedora</h3>
          <ul class="platform-list">
            <li><a href="fedora/f16/repoview">16</a></li>
            <li><a href="fedora/f15/repoview">15</a></li>
            <li><a href="fedora/f14/repoview">14</a></li>
          </ul>
        </section>

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
