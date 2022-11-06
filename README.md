# danger-danger\_plugin\_lint

[![Test](https://github.com/manicmaniac/danger-danger_plugin_lint/actions/workflows/test.yml/badge.svg)](https://github.com/manicmaniac/danger-danger_plugin_lint/actions/workflows/test.yml)

A Danger plugin to lint Danger plugin.

This plugin does the almost same thing as `danger plugins lint` command but it runs on Danger.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add danger-danger_plugin_lint

Or you can write the following code in your Gemfile.

```ruby
gem 'danger-peripher'
```

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install danger-danger_plugin_lint

## Usage

If you want to run this plugin in your plugin's repository, just add the following code in your Dangerfile.

```ruby
plugin_lint.lint_docs
```

If you want to lint a plugin outside of your plugin's `lib` directory, you can specify the path to the plugin.

```ruby
plugin_lint.lint_docs '/path/to/other_plugin.rb'
```

Or you can specify a gem file.

```ruby
plugin_lint.lint_docs '/path/to/other_plugin.gem'
```

If `warnings_as_errors` is set `true`, it reports anything as error.

```ruby
plugin_lint.lint_docs warnings_as_errors: true
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `bundle exec rake` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `lib/danger_plugin_lint/version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on [GitHub Issues](https://github.com/manicmaniac/danger-danger_plugin_lint).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
