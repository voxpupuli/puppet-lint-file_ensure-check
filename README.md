puppet-lint-file_ensure-check
==============================

[![Build Status](https://img.shields.io/travis/puppet-community/puppet-lint-file_ensure-check.svg)](https://travis-ci.org/puppet-community/puppet-lint-file_ensure-check)
[![Gem Version](https://img.shields.io/gem/v/puppet-lint-file_ensure-check.svg)](https://rubygems.org/gems/puppet-lint-file_ensure-check)
[![Gem Downloads](https://img.shields.io/gem/dt/puppet-lint-file_ensure-check.svg)](https://rubygems.org/gems/puppet-lint-file_ensure-check)
[![Coverage Status](https://img.shields.io/coveralls/puppet-community/puppet-lint-file_ensure-check.svg)](https://coveralls.io/r/puppet-community/puppet-lint-file_ensure-check?branch=master)
[![Gemnasium](https://img.shields.io/gemnasium/puppet-community/puppet-lint-file_ensure-check.svg)](https://gemnasium.com/puppet-community/puppet-lint-file_ensure-check)
[![Donated by Camptocamp](https://img.shields.io/badge/donated%20by-camptocamp-fb7047.svg)](#transfer-notice)

A puppet-lint plugin to check the ensure attribute on file resources.

## Installing

### From the command line

```shell
$ gem install puppet-lint-file_ensure-check
```

### In a Gemfile

```ruby
gem 'puppet-lint-file_ensure-check', :require => false
```

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

## Transfer Notice

This plugin was originally authored by [Camptocamp](http://www.camptocamp.com).
The maintainer preferred that Puppet Community take ownership of the module for future improvement and maintenance.
Existing pull requests and issues were transferred over, please fork and continue to contribute here instead of Camptocamp.

Previously: https://github.com/camptocamp/puppet-lint-file_ensure-check
