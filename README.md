puppet-lint-file_ensure-check
=================================

[![Build Status](https://travis-ci.org/camptocamp/puppet-lint-file_ensure-check.svg)](https://travis-ci.org/camptocamp/puppet-lint-file_ensure-check)
[![Code Climate](https://codeclimate.com/github/camptocamp/puppet-lint-file_ensure-check/badges/gpa.svg)](https://codeclimate.com/github/camptocamp/puppet-lint-file_ensure-check)
[![Gem Version](https://badge.fury.io/rb/puppet-lint-file_ensure-check.svg)](http://badge.fury.io/rb/puppet-lint-file_ensure-check)
[![Coverage Status](https://img.shields.io/coveralls/camptocamp/puppet-lint-file_ensure-check.svg)](https://coveralls.io/r/camptocamp/puppet-lint-file_ensure-check?branch=master)

A puppet-lint plugin to check the ensure attribute on file resources.


## Checks

### Ensure present on file resource

The `present` value for the `ensure` attribute is ambiguous. You should use `file` instead.

#### What you have done

```puppet
file { '/etc/sudoers':
  ensure => present,
}
```

#### What you should have done

```puppet
file { '/etc/sudoers':
  ensure => file,
}
```


#### Disabling the check

To disable this check, you can add `--no-file_ensure-check` to your puppet-lint command line.

```shell
$ puppet-lint --no-file_ensure-check path/to/file.pp
```

Alternatively, if you’re calling puppet-lint via the Rake task, you should insert the following line to your `Rakefile`.

```ruby
PuppetLint.configuration.send('disable_file_ensure')
```
