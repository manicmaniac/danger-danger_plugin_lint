# frozen_string_literal: true

RSpec.describe Danger::DangerPluginLint do
  include DangerPluginHelper
  include FixtureHelper

  let(:dangerfile) { testing_dangerfile }

  describe '#lint_docs' do
    let(:plugin_path) { fixture('test_plugin.rb') }

    shared_examples 'running with default arguments' do
      it 'reports warnings and errors' do
        dangerfile.plugin_lint.lint_docs(*refs)
        expect(dangerfile.status_report).to include(
          warnings: have_attributes(size: 3),
          errors: have_attributes(size: 3)
        )
      end
    end

    context 'when refs is not specified' do
      let(:refs) { [] }

      before do
        resolver = instance_double(Danger::PluginFileResolver)
        allow(resolver).to receive(:resolve).and_return paths: [plugin_path], gems: []
        allow(Danger::PluginFileResolver).to receive(:new).with(nil).and_return resolver
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
