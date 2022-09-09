# frozen_string_literal: true
# typed: strict

require 'open3'
require 'stringio'

module Artichoke
  module Generate
    module ThirdParty
      class CargoAbout
        extend T::Sig

        sig {returns(T::Boolean)}
        def self.present?
          _out, status = Open3.capture2e('cargo about --version')

          status.success? || false
        end

        sig {params(config: String, manifest_path: String, template: T.nilable(String)).void}
        def initialize(config:, manifest_path:, template: nil)
          template = File.join(__dir__, 'cargo_about', 'about.hbs') if template.nil?

          @template = T.let(template, String)
          @manifest_path = T.let(manifest_path, String)
          @config = T.let(config, String)
        end

        sig {returns(T::Array[Dependency])}
        def invoke
          command = ['cargo', 'about', 'generate', @template, '--manifest-path', @manifest_path, '--config', @config]
          out, err, status = Open3.capture3(command)

          warn err unless err.strip.empty?

          unless status.success?
            warn 'Generate failed'
            exit 1
          end

          Deps.parse(out)
        end
      end
    end
  end
end
