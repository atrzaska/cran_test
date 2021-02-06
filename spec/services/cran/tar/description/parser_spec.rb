# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cran::Tar::Description::Parser do
  let(:metadata) { File.read('spec/fixtures/DESCRIPTION') }

  subject { described_class.new(metadata) }

  describe '#call' do
    let(:expected) do
      {
        'Author' => 'Scott Fortmann-Roe',
        'Date' => '2015-08-15',
        'Date/Publication' => '2015-08-16 23:05:52',
        'Depends' => 'R (>= 2.15.0), xtable, pbapply',
        'Description' => 'Supplies tools for tabulating and analyzing the results of predictive models. The methods employed are applicable to virtually any predictive model and make comparisons between different methodologies straightforward.',
        'License' => 'GPL (>= 2)',
        'Maintainer' => 'Scott Fortmann-Roe <scottfr@berkeley.edu>',
        'NeedsCompilation' => 'no',
        'Package' => 'A3',
        'Packaged' => '2015-08-16 14:17:33 UTC; scott',
        'Repository' => 'CRAN',
        'Suggests' => 'randomForest, e1071',
        'Title' => 'Accurate, Adaptable, and Accessible Error Metrics for Predictive Models',
        'Type' => 'Package',
        'Version' => '1.0.0'
      }
    end

    it 'parses the description file' do
      expect(subject.call).to eq expected
    end
  end
end
