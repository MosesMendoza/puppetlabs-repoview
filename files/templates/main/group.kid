<?xml version="1.0" encoding="utf-8"?>
<?python
import time, os
def ymd(stamp):
    return time.strftime('%Y-%m-%d', time.localtime(int(stamp)))
def html_time(stamp):
    tz = time.timezone
    td = (lambda:"-", lambda:"+")[tz < 0]()
    tz = time.strftime('%H:%M', time.gmtime(abs(tz)))
    t  = time.strftime('%Y-%m-%dT%H:%M:%S', time.localtime(int(stamp)))
    return "%s%s%s" % (t, td, tz)
?>
<html xmlns:py="http://purl.org/kid/ns#" dir="ltr" lang="en-US">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title py:content="'Repoview %s' % repo_data['title']"></title>
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
      <h1 py:content="group_data['name']" />
    </section>
  </section>

  <section id="breadcrumb">
    <section class="site-width">
      <nav>
        <ul>
          <li><a href="index.html">index</a>&rarr;</li>
          <li py:content="group_data['name']" />
        </ul>
      </nav>
    </section>
  </section>

  <section id="content">
    <section class="site-width">
      <p py:content="group_data['description']" />
      <section id="package-list">
        <h2>Packages</h2>
        <ul class="pkglist">
          <li py:for="(name, filename, summary) in group_data['packages']">
            <a href="${filename}" py:content="name" /> - <span py:content="summary" />
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
