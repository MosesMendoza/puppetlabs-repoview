<?xml version="1.0" encoding="utf-8"?>
<?python
import time
def ymd(stamp):
    return time.strftime('%Y-%m-%d', time.localtime(int(stamp)))
?>
<html xmlns:py="http://purl.org/kid/ns#" dir="ltr" lang="en-US">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title py:content="'Repoview %s' % repo_data['title']"></title>
  </head>
</html>

<!-- vim: set expandtab sw=2 ts=2 sts=2 : -->
