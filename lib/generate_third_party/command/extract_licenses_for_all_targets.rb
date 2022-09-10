# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'stringio'

module Artichoke
  module GenerateThirdParty
    module Command
      class ExtractLicensesForAllTargets
        extend T::Sig

        private_class_method :new

        # Generate plaintext listing of all license texts on all supported
        # targets.
        #
        # The given manifest path should point to a `Cargo.toml` file.
        sig { params(manifest_path: String).returns(String) }
        def self.call(manifest_path)
          new.call(manifest_path)
        end

        sig { params(manifest_path: String).returns(String) }
        def call(manifest_path)
          deps = CargoAbout.invoke(
            config: cargo_about_config_path,
            manifest_path: manifest_path
          )

          s = StringIO.new
          needs_separator = T.let(false, T::Boolean)
          deps.each do |dep|
            if needs_separator
              s.puts
              s.puts '---'
              s.puts
            end

            s.puts "#{dep.name} #{dep.version}"
            s.puts ''
            s.puts dep.url
            s.puts
            s.puts dep.license_full_text

            needs_separator = true
          end

          s.string
        end

        sig { returns(String) }
        private def cargo_about_config_path
          File.join(__dir__, '..', 'targets', 'all.toml')
        end
      end
    end
  end
end
