# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'uri'

module Artichoke
  module GenerateThirdParty
    module CargoAbout
      class ReleaseInfo < T::Struct
        extend T::Sig

        const :name, String
        const :version, String
        const :download_url, URI
      end
    end
  end
end
