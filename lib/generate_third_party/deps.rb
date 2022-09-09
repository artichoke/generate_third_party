# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'stringio'
require 'yaml'

module Artichoke
  module GenerateThirdParty
    class Dependency < T::Struct
      extend T::Sig

      const :name, String
      const :version, String
      const :url, String
      const :license, String
      const :license_id, String
      const :text, String

      sig { returns(String) }
      def license_full_text
        text.gsub(
          'aaa LLVM Exceptions to the Apache 2.0 License zzzz',
          '--- LLVM Exceptions to the Apache 2.0 License ----'
        )
      end

      sig { returns(String) }
      def to_yaml
        s = StringIO.new
        s.puts <<~YAML
          - name: #{name}
            version: "#{version}"
            url: "#{url}"
            license: #{license}
            license_id: #{license_id}
        YAML

        # The `|2` indentation specifier is necessary because some licenses like
        # Apache-2.0 have initial lines that begin with whitespace.
        s.puts '  text: |2'

        license_full_text.each_line do |line|
          s.print "    #{line}"
        end
        s.string
      end
    end
  end
end
