# frozen_string_literal: true
# typed: strict

require 'stringio'
require 'yaml'

module Artichoke
  module Generate
    module ThirdParty
      module Deps
        extend T::Sig

        # Parse the output of `cargo about` and return a list of `Dependency` objects
        # alphabetized by dependency name.
        sig {params(cargo_about_output: String).returns(T::Array[Dependency])}
        def self.parse(cargo_about_output)
          # Psych won't parse a document delimiter in a quoted string, so munge it
          tx = cargo_about_output.gsub(
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

      class Dependency
        extend T::Sig

        sig {returns(String)}
        attr_reader :name

        sig {returns(String)}
        attr_reader :version

        sig {returns(String)}
        attr_reader :url

        sig {returns(String)}
        attr_reader :license

        sig {returns(String)}
        attr_reader :license_id

        sig do
          params(
            name: String,
            version: String,
            url: String,
            license: String,
            license_id: String,
            text: String,
          ).void
        end
        def initialize(name, version, url, license, license_id, text)
          @name = T.let(name, String)
          @version = T.let(version, String)
          @url = T.let(url, String)
          @license = T.let(license, String)
          @license_id = T.let(license_id, String)
          @text = T.let(text, String)
        end

        sig {params(hash: T::Hash[String, String]).returns(Dependency)}
        def self.from_hash(hash)
          new(
            hash.fetch('name'),
            hash.fetch('version'),
            hash.fetch('url'),
            hash.fetch('license'),
            hash.fetch('id'),
            hash.fetch('text')
          )
        end

        sig {returns(String)}
        def license_full_text
          @text.gsub(
            'aaa LLVM Exceptions to the Apache 2.0 License zzzz',
            '--- LLVM Exceptions to the Apache 2.0 License ----'
          )
        end

        sig {returns(String)}
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
end
