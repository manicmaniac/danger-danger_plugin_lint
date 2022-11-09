# frozen_string_literal: true

require 'danger'

module Danger
  # Analyze Danger plugin or files and report problems.
  # This plugin does the almost same as `danger plugins lint` but it runs on Danger.
  #
  # @example To run this plugin on your plugin's repo, you just run it in your Dangerfile.
  #
  #          plugin_lint.lint_docs
  #
  # @see file:README.md
  # @tags danger, plugin, lint
  class DangerPluginLint < Plugin
    # Analyze plugin files and detect documentation problems.
    #
    # @param [Array] refs                 Paths to files or gems to be linted.
    #                                     If `nil` is given, it automatically finds files.
    # @param [Boolean] warnings_as_errors If `true`, treat all warnings as errors.
    # @return [void]
    def lint_docs(*refs, warnings_as_errors: false)
      refs = refs.flatten.compact
      file_resolver = PluginFileResolver.new(refs.empty? ? nil : refs)
      data = file_resolver.resolve

      parser = PluginParser.new(data[:paths], verbose: true)
      parser.parse
      json = parser.to_json

      linter = PluginLinter.new(json)
      linter.lint
      display_rules(:fail, linter.errors)
      display_rules(warnings_as_errors ? :fail : :warn, linter.warnings)
    end

    private

    def display_rules(method, rules)
      rules.each do |rule|
        message = format_rule(rule)
        abs_file, line = rule.metadata[:files][0]
        file = Pathname.new(abs_file).relative_path_from(Dir.pwd).to_s
        public_send(method, message, file: file, line: line)
      end
    end

    def format_rule(rule)
      <<~HTML
        <strong>#{rule.title}</strong> - <strong>#{rule.metadata[:name]}</strong> (#{rule.type}):
        #{to_html(rule.description)}
        #{link(rule.ref)}
      HTML
    end

    def link(ref)
      url = case ref
            when Range
              "https://github.com/dbgrandi/danger-prose/blob/v2.0.0/lib/danger_plugin.rb#L#{ref.min}-L#{ref.max}"
            when Integer
              "https://github.com/dbgrandi/danger-prose/blob/v2.0.0/lib/danger_plugin.rb#L#{ref}"
            else
              'https://github.com/dbgrandi/danger-prose/blob/v2.0.0/lib/danger_plugin.rb'
            end
      %(@see - <a href="#{url}">#{url}</a>)
    end

    def to_html(markdown)
      # As the current Danger uses nothing but backquotes in syntax of Markdown,
      # this method just replaces backquotes to `<code>` tag.
      # @see https://github.com/danger/danger/blob/v9.0.0/lib/danger/plugin_support/plugin_linter.rb#L93-L128
      markdown.gsub(/`(.*?)`/, '<code>\1</code>')
    end
  end
end
