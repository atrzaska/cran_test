# frozen_string_literal: true

module Cran
  class Package
    attr_reader :metadata

    def initialize(metadata)
      @metadata = metadata
    end

    def title
      field('Package')
    end

    def version
      field('Version')
    end

    def description
      field('Description')
    end

    def author
      field('Author')
    end

    def maintainer
      field('Maintainer')
    end

    def license
      field('License')
    end

    def publication_date
      @publication_date ||= DateTime.parse(field('Date/Publication'))
    end

    def url
      "#{Cran::URL_BASE}/#{file_name}"
    end

    def file_name
      "#{title}_#{version}.tar.gz"
    end

    private

    def field(name)
      parsed_metadata[name] || parsed_description[name]
    end

    def parsed_metadata
      @parsed_metadata ||= Cran::Tar::Description::Parser.call(metadata)
    end

    def parsed_description
      @parsed_description ||= begin
        tar_description = Cran::Tar::Description::Fetch.call(self)
        Cran::Tar::Description::Parser.call(tar_description)
      end
    end
  end
end
