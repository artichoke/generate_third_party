# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative 'generate_third_party/bin_tools'
require_relative 'generate_third_party/cargo_about'
require_relative 'generate_third_party/cargo_about/platform'
require_relative 'generate_third_party/cargo_about/release_info'
require_relative 'generate_third_party/deps'
require_relative 'generate_third_party/target'

require_relative 'generate_third_party/command/extract_licenses_for_all_targets'
require_relative 'generate_third_party/command/extract_licenses_for_single_target'
require_relative 'generate_third_party/command/parse_cargo_about_output'
