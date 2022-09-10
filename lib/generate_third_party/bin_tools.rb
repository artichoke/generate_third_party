# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Artichoke
  module GenerateThirdParty
    module BinTools
      extend T::Sig

      sig { void }
      def self.setup_script_signal_handlers!
        # avoid ugly stacks on permissible signals
        Signal.trap('INT', 'SYSTEM_DEFAULT') if Signal.list.include?('INT')
        Signal.trap('PIPE', 'SYSTEM_DEFAULT') if Signal.list.include?('PIPE')
      end
    end
  end
end
