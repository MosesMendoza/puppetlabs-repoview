# Puppet Labs repoview

This module is used internally by Puppet Labs to generate and manage static HTML
pages using the repoview tool.

## Usage

Should be as easy as

```
include repoview
```

There are a few default parameters which may need to be changed:

*   `$basetitle` - Title to be displayed on HTML pages. Defaults to 'Puppet Labs
    Yum Repository'.
*   `$basepath` - Absolute path to yum repository. Defaults to `/var/www/yum`.
*   `$temporaryrepos` - List of relative paths from `$basepath` at which to
    generate temporary repositories. These are paths at which a yum repoistory
    does not exist but you still desire to have a view for these paths. A
    repository will be created at this location, the HTML pages generated, and
    the repository files removed. This currently defaults the main repo and each
    supported platform and OS version (EL 5 & 6, Fedora 14, 15 & 16).
*   `$otherrepos` - List of relative paths from `$basepath` at which
    repositories already exist and should have an HTML view generated. This
    currently defaults to the product and dependency directories under each
    platform and OS version.

If any of these need to be overwritten, the class can be included as, e.g.

```
class { 'repoview':
  basetitle = 'Acme Yum Repository',
  basepath = '/var/www',
}
```

## HTML Templates

`repoview` uses templates (using Python's kid templating engine) to generate the
HTML pages. This engine and the variables exposed by repoview are not documented
other than in `repoview`'s default set of templates. This module make use of
four different sets of templates (all found in `files/templates`) to generate
various views. The `main` templates are used for the main landing page. Under
the `specific` directory, the `platform` templates are used for the temporary
repository view generated for each platform and OS version; and the `product`
and `dependencies` templates are used for the product and dependencies views,
respectively.

## repoview Binary

The `repoview` binary (a Python script) is included in and managed by this
module since a package for it only exists for Red Hat/CentOS/etc. It also
includes a patch to make the output directory option function correctly. (This
patch has been filed upstream, but it is unlikely to be merged as `repoview` is
not under active development.)
