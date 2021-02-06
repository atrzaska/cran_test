# frozen_string_literal: true

require 'rubygems/package'
require 'zlib'

module Cran
  module Tar
    module Description
      class Fetch
        CACHE_TTL = 1.day

        include Service

        def initialize(package)
          @package = package
        end

        def call
          Rails.cache.fetch(cache_key, expires_in: CACHE_TTL) do
            encoded_description
          end
        end

        private

        def encoded_description
          extract_description.encode('utf-8')
        rescue Encoding::InvalidByteSequenceError
          extract_description.force_encoding('windows-1250').encode('utf-8')
        rescue Encoding::UndefinedConversionError
          extract_description
        end

        def extract_description
          file = URI.open(url)

          unzipped = Zlib::GzipReader.new(file)

          Gem::Package::TarReader.new(unzipped) do |tar|
            tar.each do |entry|
              return entry.read if entry.full_name == description_file
            end
          end
        end

        def cache_key
          "cran:package:#{title}:#{version}:description"
        end

        def description_file
          "#{title}/DESCRIPTION"
        end

        attr_reader :package

        delegate :title, :version, :url, to: :package
      end
    end
  end
end
