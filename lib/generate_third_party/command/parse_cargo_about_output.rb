# typed: strict
# frozen_string_literal: true

require 'json'
require 'sorbet-runtime'

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

        # rubocop:disable Sorbet/ForbidTUntyped
        sig { params(raw: String).returns(T::Array[Dependency]) }
        def call(raw)
          data = JSON.parse(raw)
          licenses = T.let(data['licenses'], T::Array[T::Hash[String, T.untyped]])

          deps = T.let([], T::Array[Dependency])
          deps << ExternalDeps::MRUBY
          deps << ExternalDeps::ONIGURUMA

          licenses.each do |license|
            license_name = T.let(license['name'], String)
            license_id = T.let(license['id'], String)
            license_text = T.let(license['text'], String)

            used_by = T.let(license['used_by'], T::Array[T::Hash[String, T.untyped]])
            used_by.each do |entry|
              crate = T.let(entry['crate'], T::Hash[String, T.untyped])

              crate_name = T.let(crate['name'], String)
              crate_version = T.let(crate['version'], String)
              crate_description = T.let(crate['description'], T.nilable(String))

              crate_url = T.let(nil, T.nilable(String))
              if crate_url.nil?
                homepage = T.let(crate['homepage'], T.nilable(String))
                crate_url = homepage
              end
              if crate_url.nil?
                repository = T.let(crate['repository'], T.nilable(String))
                crate_url = repository
              end
              if crate_url.nil?
                docs = T.let(crate['documentation'], T.nilable(String))
                crate_url = docs
              end

              deps << Dependency.new(
                name: crate_name,
                version: crate_version,
                url: crate_url,
                description: crate_description,
                license: license_name,
                license_id: license_id,
                license_text: license_text
              )
            end
          end

          deps.sort_by!(&:name)
        end
        # rubocop:enable Sorbet/ForbidTUntyped
      end
    end
  end
end
