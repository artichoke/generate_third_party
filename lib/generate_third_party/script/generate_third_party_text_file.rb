# typed: strict
# frozen_string_literal: true

require 'optparse'
require 'sorbet-runtime'

module Artichoke
  module GenerateThirdParty
    module Script
      class GenerateThirdPartyTextFile
        extend T::Sig

        class Arguments < T::Struct
          extend T::Sig

          const :manifest_path, String

          sig { returns(Arguments) }
          def self.from_argv!
            option_parser = OptionParser.new do |opts|
              opts.banner = 'Usage: generate-third-party-text-file path/to/Cargo.toml'
            end

            begin
              option_parser.parse!
            rescue OptionParser::InvalidOption => e
              warn option_parser
              warn ''
              warn e
              exit(2)
            end

            manifest_path, *rest = ARGV
            if manifest_path.nil? || rest.nil? || !rest.empty? || !manifest_path.end_with?('Cargo.toml')
              warn option_parser
              exit(2)
            end

            new(manifest_path: manifest_path)
          end
        end

        private_class_method :new

        sig { void }
        def self.main
          BinTools.setup_script_signal_handlers!

          args = Arguments.from_argv!
          CargoAbout.assert_on_path!

          license_listing = Command::ExtractLicensesForAllTargets.call(args.manifest_path)
          puts license_listing
        end
      end
    end
  end
end
