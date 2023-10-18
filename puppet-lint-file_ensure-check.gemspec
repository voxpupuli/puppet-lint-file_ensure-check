Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-file_ensure-check'
  spec.version     = '2.0.0'
  spec.homepage    = 'https://github.com/voxpupuli/puppet-lint-file_ensure-check'
  spec.license     = 'Apache-2.0'
  spec.author      = 'Vox Pupuli'
  spec.email       = 'voxpupuli@groups.io'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.summary     = 'A puppet-lint plugin to check the ensure attribute on file resources.'
  spec.description = <<-EOF
    A puppet-lint plugin to check the ensure attribute on file resources.
  EOF

  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency 'puppetlabs-puppet-lint', '~> 5.0'
  spec.add_development_dependency 'mime-types', '~> 3.4', '>= 3.4.1'
end
