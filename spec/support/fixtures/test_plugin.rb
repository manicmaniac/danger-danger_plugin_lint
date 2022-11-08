# frozen_string_literal: true

require 'danger'

module Danger
  class TestPlugin < Plugin
    def test_method; end

    def test_method_1; end
  end
end

# With danger 9.0.0, `danger plugins lint /path/to/test_plugin.rb` emits the following errors.
#
# Errors
#   - Description Markdown - TestPlugin (class):
#     - Above your class you need documentation that covers the scope, and the usage of your plugin.
#     - @see - https://github.com/dbgrandi/danger-prose/blob/v2.0.0/lib/danger_plugin.rb#L4#-L6
#     - /path/to/danger-danger_plugin_lint/spec/support/fixtures/test_plugin.rb:6
#
#   - Examples - TestPlugin (class):
#     - You should include some examples of common use-cases for your plugin.
#     - @see - https://github.com/dbgrandi/danger-prose/blob/v2.0.0/lib/danger_plugin.rb#L8#-L27
#     - /path/to/danger-danger_plugin_lint/spec/support/fixtures/test_plugin.rb:6
#
#   - Description - test_method (method):
#     - You should include a description for your method.
#     - @see - https://github.com/dbgrandi/danger-prose/blob/v2.0.0/lib/danger_plugin.rb#L40#-L41
#     - /path/to/danger-danger_plugin_lint/spec/support/fixtures/test_plugin.rb:7
#
#
# Warnings
#   - Tags - TestPlugin (class):
#     - This plugin does not include `@tags tag1, tag2` and thus will be harder to find in search.
#     - @see - https://github.com/dbgrandi/danger-prose/blob/v2.0.0/lib/danger_plugin.rb#L30
#     - /path/to/danger-danger_plugin_lint/spec/support/fixtures/test_plugin.rb:6
#
#   - References - TestPlugin (class):
#     - Ideally, you have a reference implementation of your plugin that you can show to people, add `@see org/repo`
#       to have the site auto link it.
#     - @see - https://github.com/dbgrandi/danger-prose/blob/v2.0.0/lib/danger_plugin.rb#L29
#     - /path/to/danger-danger_plugin_lint/spec/support/fixtures/test_plugin.rb:6
#
#   - Return Type - test_method (method):
#     - If the function has no useful return value, use ` @return  [void]` - this will be ignored by documentation
#       generators.
#     - @see - https://github.com/dbgrandi/danger-prose/blob/v2.0.0/lib/danger_plugin.rb#L46
#     - /path/to/danger-danger_plugin_lint/spec/support/fixtures/test_plugin.rb:7
