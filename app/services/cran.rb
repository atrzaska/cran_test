# frozen_string_literal: true

require 'open-uri'

module Cran
  URL_BASE = 'https://cran.r-project.org/src/contrib'
  PACKAGES_URL = "#{URL_BASE}/PACKAGES"
  PACKAGE_REGEXP = /\n\n/

  def self.get_packages
    data = URI.open(PACKAGES_URL).read
    metadatas = data.split(PACKAGE_REGEXP)
    metadatas.map { |metadata| Package.new(metadata) }
  end
end
