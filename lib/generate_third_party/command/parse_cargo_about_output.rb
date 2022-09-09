# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'yaml'

module Artichoke
  module GenerateThirdParty
    module Command
      class ParseCargoAboutOutput
        extend T::Sig

        private_class_method :new

        # Parse the output of `cargo about` and return a list of `Dependency`
        # objects alphabetized by dependency name.
        sig { params(raw: String).returns(T::Array[Dependency]) }
        def self.call(raw)
          new.call(raw)
        end

        sig { params(raw: String).returns(T::Array[Dependency]) }
        def call(raw)
          # Psych won't parse a document delimiter in a quoted string, so munge it
          tx = raw.gsub(
            '--- LLVM Exceptions to the Apache 2.0 License ----',
            'aaa LLVM Exceptions to the Apache 2.0 License zzzz'
          )

          # turn license text blocks into pipe-delimited literal multi-line strings
          is_text = T.let(false, T::Boolean)
          tx = tx.each_line.map do |line|
            if is_text && line == "@@@@text-end@@@@\n"
              is_text = false
              next nil
            end
            next "      #{line}" if is_text

            if line == "@@@@text-start@@@@\n"
              is_text = true
              # The `|2` indentation specifier is necessary because some licenses like
              # Apache-2.0 have initial lines that begin with whitespace.
              next "    text: |2\n"
            end
            line
          end

          yaml_output = tx.compact.join

          deps = YAML.safe_load(yaml_output)
          deps = deps['deps'].map do |hash|
            Dependency.from_hash(hash)
          end

          deps.sort_by!(&:name)
        end
      end
    end
  end
end
