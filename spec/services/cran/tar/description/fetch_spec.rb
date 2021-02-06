# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cran::Tar::Description::Fetch do
  let(:package_metadata) { File.read('spec/fixtures/package1.txt') }
  let(:package) { Cran::Package.new(package_metadata) }
  let(:url) { package.url }
  let(:description) { File.read('spec/fixtures/DESCRIPTION') }
  let(:tar_file) { File.open('spec/fixtures/A3_1.0.0.tar.gz') }

  subject { described_class.new(package) }

  describe '#call' do
    it 'returns description file data for a package' do
      expect(URI).to receive(:open).with(url).and_return(tar_file)
      expect(Zlib::GzipReader).to receive(:new).with(tar_file).and_call_original
      expect(Gem::Package::TarReader).to receive(:new).and_call_original
      expect(subject.call).to eq description
    end
  end
end
