# frozen_string_literal: true

require 'danger'

module Danger
  class DangerPluginLint < Plugin
    def lint_docs(refs = nil, warnings_as_errors: false)
      file_resolver = PluginFileResolver.new(refs)
      data = file_resolver.resolve

      parser = PluginParser.new(data[:paths], verbose: true)
      parser.parse
      json = parser.to_json

      linter = PluginLinter.new(json)
      linter.lint
      display_rules(:fail, linter.errors)
      display_rules(:warn, linter.warnings)
    end

    private

    def display_rules(method, rules)
      rules.each do |rule|
        abs_file, line = rule.metadata[:files][0]
        file = Pathname.new(abs_file).relative_path_from(Dir.pwd).to_s
        public_send(method, rule.description, file: file, line: line)
      end
    end
  end
end
