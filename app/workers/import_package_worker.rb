# frozen_string_literal: true

class ImportPackageWorker
  include Sidekiq::Worker

  def perform(metadata)
    cran_package = Cran::Package.new(metadata)
    package = Package.find_or_initialize_by(title: cran_package.title)

    package.update(
      version: cran_package.version,
      description: cran_package.description,
      author: cran_package.author,
      maintainer: cran_package.maintainer,
      license: cran_package.license,
      publication_date: cran_package.publication_date
    )
  end
end
