# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'
require 'stringio'

module Artichoke
  module Generate
    module ThirdParty
      module OneTarget
        extend T::Sig
        sig {params(target: String, manifest_path: String).returns(String)}
        def self.third_party_flatfile(target, manifest_path)
          cmd = CargoAbout.new(
            config: File.join(__dir__, 'one_target', "#{target}.toml"),
            manifest_path:
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
