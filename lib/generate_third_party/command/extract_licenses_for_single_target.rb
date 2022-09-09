# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'stringio'

module Artichoke
  module GenerateThirdParty
    module Command
      class ExtractLicensesForSingleTarget
        extend T::Sig

        sig { params(target: Target, manifest_path: String).returns(String) }
        def self.call(target, manifest_path)
          cmd = CargoAbout.new(
            config: target.cargo_about_config_path,
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
      end
    end
  end
end