# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'stringio'

module Artichoke
  module GenerateThirdParty
    module Command
      class ExtractLicensesForAllTargets
        extend T::Sig

        sig { params(manifest_path: String).returns(String) }
        def self.call(manifest_path)
          cmd = CargoAbout.new(
            config: cargo_about_config_path,
            manifest_path: manifest_path
          )

          deps = cmd.invoke

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
        private_class_method def self.cargo_about_config_path
          File.join(__dir__, '..', 'targets', 'all.toml')
        end
      end
    end
  end
end
