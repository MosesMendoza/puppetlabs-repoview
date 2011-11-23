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
      <h1 py:content="pkg_data['name']" />
    </section>
  </section>

  <section id="breadcrumb">
    <section class="site-width">
      <nav>
        <ul>
          <li><a href="index.html">index</a>&rarr;</li>
          <li><a href="${group_data['filename']}" py:content="group_data['name']" />&rarr;</li>
          <li py:content="pkg_data['name']" />
        </ul>
      </nav>
    </section>
  </section>

  <section id="content">
    <section class="site-width">

      <h2 id="package-name" py:content="'%s - %s' % (pkg_data['name'], pkg_data['summary'])" />

      <table id="package-summary">
        <tbody>
          <tr>
            <th>Website:</th>
            <td><a href="${pkg_data['url']}" py:content="pkg_data['url']" /></td>
          </tr>
          <tr>
            <th>License:</th>
            <td py:content="pkg_data['rpm_license']" />
          </tr>
        </tbody>
      </table>

      <dl id="package-description">
        <dt>Description:</dt>
        <dd><pre py:content="pkg_data['description']" /></dd>
      </dl>

      <h3>Packages</h3>
      <table id="package-downloads">
        <tr py:for="(epoch, version, release, arch, built, size, location, author, log, added) in pkg_data['rpms']">
          <td><a href="${'../%s' % location}" py:content="'%s-%s-%s.%s' % (pkg_data['name'], version, release, arch)" /></td>
          <td>
            <strong>Changelog</strong> by <span py:content="'%s' % author" /> (<time datetime="${html_time(added)}" py:content="'%s' % ymd(added)" />)
            <pre py:content="log" />
          </td>
        </tr>
      </table>

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
