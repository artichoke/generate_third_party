# typed: strict
# frozen_string_literal: true

require 'open3'
require 'sorbet-runtime'

module Artichoke
  module GenerateThirdParty
    module CargoAbout
      extend T::Sig

      sig { returns(T::Boolean) }
      def self.present?
        _out, status = Open3.capture2e('cargo about --version')

        status.success? || false
      end

      sig { void }
      def self.assert_on_path!
        return if present?

        warn <<~ERR
          Error: `cargo-about` not found in PATH.

          Try installing `cargo-about` with:

          $ install-cargo-about
        ERR
        exit(1)
      end

      sig { params(config: String, manifest_path: String, template: T.nilable(String)).returns(T::Array[Dependency]) }
      def self.invoke(config:, manifest_path:, template: nil)
        template = File.join(__dir__, 'cargo_about', 'about.hbs') if template.nil?

        command = ['cargo', 'about', 'generate', template, '--manifest-path', manifest_path, '--config', config]
        out, err, status = Open3.capture3(*command)

        warn err unless err.strip.empty?

        unless status.success?
          warn 'Generate failed'
          exit 1
        end

        Command::ParseCargoAboutOutput.call(out)
      end
    end
  end
end
