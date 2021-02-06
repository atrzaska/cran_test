# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'packages:refresh' do
  let(:package1) { Cran::Package.new(File.read('spec/fixtures/package1.txt')) }
  let(:package2) { Cran::Package.new(File.read('spec/fixtures/package2.txt')) }
  let(:packages) { [package1, package2] }

  before do
    Rails.application.load_tasks
    expect(Cran).to receive(:get_packages).and_return(packages)
  end

  it 'schedules worker for each package' do
    packages.each do |package|
      expect(ImportPackageWorker).to receive(:perform_async).with(package.metadata)
    end

    Rake::Task['packages:refresh'].invoke
  end
end
