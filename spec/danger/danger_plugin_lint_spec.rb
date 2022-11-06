# frozen_string_literal: true

RSpec.describe Danger::DangerPluginLint do
  include DangerPluginHelper
  include FixtureHelper

  let(:dangerfile) { testing_dangerfile }

  describe '#lint_docs' do
    let(:refs) { [fixture('test_plugin.rb')] }

    context 'when refs is a string' do
      let(:refs) { fixture('test_plugin.rb') }

      it 'reports warnings and errors about the given path' do
        dangerfile.plugin_lint.lint_docs(refs)
        expect(dangerfile.status_report).to include(
          warnings: have_attributes(size: 3),
          errors: have_attributes(size: 3)
        )
      end
    end

    context 'when warnings_as_errors is true' do
      it 'reports everything as error' do
        dangerfile.plugin_lint.lint_docs(refs, warnings_as_errors: true)
        expect(dangerfile.status_report).to include(
          warnings: be_empty,
          errors: have_attributes(size: 6)
        )
      end
    end

    it 'reports warnings and errors separately' do
      dangerfile.plugin_lint.lint_docs(refs)
      expect(dangerfile.status_report).to include(
        warnings: have_attributes(size: 3),
        errors: have_attributes(size: 3)
      )
    end
  end
end
