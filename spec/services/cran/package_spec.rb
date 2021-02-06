# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cran::Package do
  let(:metadata) { File.read('spec/fixtures/package1.txt') }
  let(:description_data) { File.read('spec/fixtures/DESCRIPTION') }

  let(:expect_fetch_description) do
    expect(Cran::Tar::Description::Fetch).to receive(:call)
      .with(subject).and_return(description_data)
  end

  subject { described_class.new(metadata) }

  describe '#title' do
    it 'returns package title' do
      expect(subject.title).to eq 'A3'
    end
  end

  describe '#version' do
    it 'returns package title' do
      expect(subject.version).to eq '1.0.0'
    end
  end

  describe '#url' do
    it 'returns package title' do
      expect(subject.url).to eq 'https://cran.r-project.org/src/contrib/A3_1.0.0.tar.gz'
    end
  end

  describe '#file_name' do
    it 'returns package title' do
      expect(subject.file_name).to eq 'A3_1.0.0.tar.gz'
    end
  end

  describe '#description' do
    let(:expected) do
      'Supplies tools for tabulating and analyzing the results of predictive models. '\
        'The methods employed are applicable to virtually any predictive model and '\
        'make comparisons between different methodologies straightforward.'
    end

    it 'returns package title' do
      expect_fetch_description
      expect(subject.description).to eq expected
    end
  end

  describe '#author' do
    it 'returns package title' do
      expect_fetch_description
      expect(subject.author).to eq 'Scott Fortmann-Roe'
    end
  end

  describe '#maintainer' do
    it 'returns package title' do
      expect_fetch_description
      expect(subject.maintainer).to eq 'Scott Fortmann-Roe <scottfr@berkeley.edu>'
    end
  end

  describe '#license' do
    it 'returns package title' do
      expect(subject.license).to eq 'GPL (>= 2)'
    end
  end

  describe '#publication_date' do
    let(:expected) { '2015-08-16T23:05:52+00:00' }

    it 'returns package title' do
      expect_fetch_description
      expect(subject.publication_date.iso8601).to eq expected
    end
  end
end
