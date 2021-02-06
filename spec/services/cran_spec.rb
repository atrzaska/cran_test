# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cran do
  describe '#get_packages' do
    let(:open_double) { double }
    let(:packages_file) { File.read('spec/fixtures/PACKAGES') }

    subject { described_class.get_packages }

    before do
      expect(URI).to receive(:open).and_return(open_double)
      expect(open_double).to receive(:read).and_return(packages_file)
    end

    it 'returns all packages' do
      expect(subject.count).to eq 17_085
    end

    it 'parses the document' do
      expect(subject.first.class).to eq Cran::Package
    end
  end
end
