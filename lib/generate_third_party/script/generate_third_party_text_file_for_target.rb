# typed: strict
# frozen_string_literal: true

require 'optparse'
require 'sorbet-runtime'

module Artichoke
  module GenerateThirdParty
    module Script
      class GenerateThirdPartyTextFileForTarget
        extend T::Sig

        class Arguments < T::Struct
          extend T::Sig

          const :manifest_path, String
          const :target, Target

          sig { returns(Arguments) }
          def self.from_argv!
            target = T.let(nil, T.nilable(Target))

            option_parser = OptionParser.new do |opts|
              opts.banner = 'Usage: generate-third-party-text-file path/to/Cargo.toml'

              opts.on('-t', '--target TARGET', 'Target platform triple') do |arg|
                target = Target.try_deserialize(arg)
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

            manifest_path, *rest = ARGV
            if manifest_path.nil? || rest.nil? || !rest.empty? || !manifest_path.end_with?('Cargo.toml') || target.nil?
              warn option_parser.to_s
              exit(2)
            end

            new(manifest_path: manifest_path, target: target)
          end
        end

        private_class_method :new

        sig { void }
        def self.main
          BinTools.setup_script_signal_handlers!

          args = Arguments.from_argv!
          CargoAbout.assert_on_path!

          license_listing = Command::ExtractLicensesForSingleTarget.call(args.target, args.manifest_path)
          puts license_listing
        end
      end
    end
  end
end
