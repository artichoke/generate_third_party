# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Artichoke
  module GenerateThirdParty
    class Target < T::Enum
      extend T::Sig

      enums do
        Aarch64AppleDarwin = new('aarch64-apple-darwin')
        Aarch64UnknownLinuxGNU = new('aarch64-unknown-linux-gnu')
        AArch64UnknownLinuxMusl = new('aarch64-unknown-linux-musl')
        I686PcWindowsGNU = new('i686-pc-windows-gnu')
        I686PcWindowsMSVC = new('i686-pc-windows-msvc')
        I686UnknownLinuxGNU = new('i686-unknown-linux-gnu')
        X86_64AppleDarwin = new('x86_64-apple-darwin')
        X86_64PcWindowsGNU = new('x86_64-pc-windows-gnu')
        X86_64PcWindowsMSVC = new('x86_64-pc-windows-msvc')
        X86_64UnknownLinuxGNU = new('x86_64-unknown-linux-gnu')
        X86_64UnknownLinuxMusl = new('x86_64-unknown-linux-musl')
      end

      sig { returns(String) }
      def cargo_about_config_path
        File.join(__dir__, 'targets', "#{serialize}.toml")
      end
    end
  end
end
