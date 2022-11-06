# frozen_string_literal: true

RSpec.describe Danger::DangerPluginLint do
  include DangerPluginHelper
  include FixtureHelper

  let(:dangerfile) { testing_dangerfile }

  describe '#lint_docs' do
    let(:warnings) { dangerfile.status_report[:warnings] }
    let(:errors) { dangerfile.status_report[:errors] }
    let(:refs) { [fixture('test_plugin.rb')] }

    context 'when warnings_as_errors is true' do
      it 'reports everything as error' do
        dangerfile.plugin_lint.lint_docs(refs, warnings_as_errors: true)
        expect(warnings).to be_empty
        expect(errors).to have_attributes size: 6
      end
    end

    it 'reports warnings and errors separately' do
      dangerfile.plugin_lint.lint_docs(refs, warnings_as_errors: false)
      expect(warnings).to match_array [
        /reference implementation/,
        /@tags/,
        /no useful return value/
      ]
      expect(errors).to match_array [
        /documentation that covers the scope/,
        /description for your method/,
        /examples of common use-cases/
      ]
    end
  end
end
