# typed: strict
# frozen_string_literal: true

require 'open-uri'
require 'optparse'
require 'rubygems/package'
require 'sorbet-runtime'

module Artichoke
  module GenerateThirdParty
    module Script
      class InstallCargoAbout
        extend T::Sig

        class Arguments < T::Struct
          extend T::Sig

          const :platform, CargoAbout::Platform

          sig { returns(Arguments) }
          def self.from_argv!
            platform = T.let(nil, T.nilable(CargoAbout::Platform))

            option_parser = OptionParser.new do |opts|
              opts.banner = 'Usage: install-cargo-about'

              opts.on('-p', '--platform PLATFORM', 'cargo-about release OS') do |arg|
                platform = CargoAbout::Platform.try_from_case_insensitive(arg)
              end
            end

            begin
              option_parser.parse!
            rescue OptionParser::InvalidOption => e
              warn option_parser.to_s
              warn ''
              warn e.to_s
              exit(2)
            end

            if !ARGV.empty? || platform.nil?
              warn option_parser.to_s
              exit(2)
            end

            new(platform: platform)
          end
        end

        private_class_method :new

        sig { void }
        def self.main
          BinTools.setup_script_signal_handlers!

          args = Arguments.from_argv!
          return if CargoAbout.present?

          release = BinTools.log_group('Get current cargo-about release') do
            BinTools.retry_with(times: 5) do
              cargo_about_release = args.platform.release_info
              puts "Found cargo-about #{cargo_about_release.version}"
              puts "cargo-about download URL: #{cargo_about_release.download_url}"
              cargo_about_release
            end
          end

          path = BinTools.log_group('Install cargo-about') do
            destination = BinTools.retry_with(times: 5) do
              temp_dir = BinTools.temp_dir
              puts "Downloading cargo-about from #{release.download_url}"

              T.unsafe(release.download_url).open do |data|
                puts 'Download in progress'
                puts "Extracting tarball to #{temp_dir}"

                Gem::Package.new('').extract_tar_gz(data, temp_dir)

                puts 'Extraction complete'

                temp_dir
              end
            end

            bin_path = File.join(destination, release.name.delete_suffix('.tar.gz'))

            puts "Installed cargo-about to #{destination}"
            puts "Binary path: #{bin_path}"

            bin_path
          end

          BinTools.log_group('Modifying path') do
            BinTools.add_to_github_actions_runner_path(path)
            puts "Entries added to path:\n\t#{path}"
          end
        end
      end
    end
  end
end
