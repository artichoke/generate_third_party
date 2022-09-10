# typed: strict
# frozen_string_literal: true

require 'json'
require 'open-uri'
require 'sorbet-runtime'
require 'stringio'
require 'uri'

module Artichoke
  module GenerateThirdParty
    module CargoAbout
      class Platform < T::Enum
        extend T::Sig

        enums do
          Linux = new('linux')
          MacOS = new('macos')
          Windows = new('windows')
        end

        sig { params(os: String).returns(T.nilable(Platform)) }
        def self.try_from_case_insensitive(os)
          try_deserialize(os.downcase)
        end

        sig { returns(ReleaseInfo) }
        def release_info
          releases_endpoint = URI.parse('https://api.github.com/repos/EmbarkStudios/cargo-about/releases')

          headers = { 'Content-Type' => 'application/json' }
          if (github_token = ENV.fetch('GITHUB_TOKEN', nil))
            headers['Authorization'] = "Bearer #{github_token}"
          end

          T.unsafe(releases_endpoint).open(headers) do |data|
            buf = StringIO.new
            IO.copy_stream(data, T.unsafe(buf))

            metadata = JSON.parse(buf.string)
            release = metadata.fetch(0)
            assets = release.fetch('assets')
            artifact = assets.find { |asset| release_filter.match?(asset.fetch('browser_download_url')) }

            ReleaseInfo.new(
              name: artifact.fetch('name'),
              version: release.fetch('tag_name'),
              download_url: URI.parse(artifact.fetch('browser_download_url'))
            )
          end
        end

        sig { returns(Regexp) }
        private def release_filter
          case self
          when Platform::Linux then /.*x86_64-unknown-linux.*tar.gz$/
          when Platform::MacOS then /.*x86_64-apple-darwin.*tar.gz$/
          when Platform::Windows then /.*x86_64-pc-windows-msvc.*tar.gz$/
          else
            T.absurd(self)
          end
        end
      end
    end
  end
end
