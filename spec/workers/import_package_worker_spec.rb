# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportPackageWorker do
  let(:metadata) { File.read('spec/fixtures/DESCRIPTION') }
  let(:cran_package) { Cran::Package.new(metadata) }
  let(:package) { Package.last }
  let(:title) { 'A3' }
  let(:version) { '1.0.0' }

  describe '#perform' do
    context 'package already exists' do
      before do
        Package.create(title: title, version: version)
      end

      it 'does not create new database record' do
        expect { subject.perform(metadata) }.to_not change { Package.count }
      end

      context 'package record is outdated' do
        let(:version) { '0.0.1' }

        it 'package is updated' do
          subject.perform(metadata)
          expect(package.version).to eq cran_package.version
        end
      end
    end

    context 'package not found in database' do
      it 'adds cran package to database' do
        expect { subject.perform(metadata) }.to change { Package.count }.by 1
      end

      it 'package is stored correctly' do
        subject.perform(metadata)
        expect(package.title).to eq cran_package.title
        expect(package.version).to eq cran_package.version
        expect(package.author).to eq cran_package.author
        expect(package.description).to eq cran_package.description
        expect(package.license).to eq cran_package.license
        expect(package.maintainer).to eq cran_package.maintainer
        expect(package.publication_date).to eq cran_package.publication_date
      end
    end
  end
end
