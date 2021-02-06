# frozen_string_literal: true

namespace :packages do
  desc 'Refresh packages database'
  task refresh: :environment do
    Cran.get_packages.each do |package|
      ImportPackageWorker.perform_async(package.metadata)
    end
  end
end
