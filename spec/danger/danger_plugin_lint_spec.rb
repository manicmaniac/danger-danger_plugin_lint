# frozen_string_literal: true

RSpec.describe Danger::DangerPluginLint do
  include DangerPluginHelper
  include FixtureHelper

  let(:dangerfile) { testing_dangerfile }

  describe '#lint_docs' do
    let(:plugin_path) { fixture('test_plugin.rb') }

    shared_examples 'running with default arguments' do
      before { dangerfile.plugin_lint.lint_docs(*refs) }

      it 'reports errors' do
        expect(dangerfile.status_report[:errors]).to contain_exactly(
          a_string_starting_with('**Description Markdown** - **TestPlugin** (class):'),
          a_string_starting_with('**Examples** - **TestPlugin** (class):'),
          a_string_starting_with('**Description** - **test_method** (method):')
        )
      end

      it 'reports warnings' do
        expect(dangerfile.status_report[:warnings]).to contain_exactly(
          a_string_starting_with('**Tags** - **TestPlugin** (class):'),
          a_string_starting_with('**References** - **TestPlugin** (class):'),
          a_string_starting_with('**Return Type** - **test_method** (method):')
        )
      end
    end

    context 'when refs is not specified' do
      let(:refs) { [] }

      before do
        allow(Dir).to receive(:glob).and_call_original
        allow(Dir).to receive(:glob).with(File.join('.', 'lib/**/*.rb')).and_return [plugin_path]
      end

      it_behaves_like 'running with default arguments'
    end

    context 'when refs is a string' do
      let(:refs) { [plugin_path] }

      it_behaves_like 'running with default arguments'
    end

    context 'when refs is an array' do
      let(:refs) { [[plugin_path]] }

      it_behaves_like 'running with default arguments'
    end

    context 'when warnings_as_errors is true' do
      let(:refs) { [plugin_path] }

      it 'reports everything as error' do
        dangerfile.plugin_lint.lint_docs(refs, warnings_as_errors: true)
        expect(dangerfile.status_report).to include(
          warnings: be_empty,
          errors: have_attributes(size: 6)
        )
      end
    end
  end
end
