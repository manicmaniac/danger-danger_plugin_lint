# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'danger-danger_plugin_lint'
  spec.version = '0.1.0'
  spec.authors = ['Ryosuke Ito']
  spec.email = ['rito.0305@gmail.com']

  spec.summary = 'A Danger plugin to lint Danger plugin'
  spec.description = spec.summary
  spec.homepage = 'https://github.com/manicmaniac/danger-danger_plugin_lint'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*.rb']
  spec.require_paths = ['lib']

  spec.add_dependency 'danger-plugin-api', '~> 1.0'
end
