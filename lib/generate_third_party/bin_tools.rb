# typed: strict
# frozen_string_literal: true

require 'fileutils'
require 'securerandom'
require 'sorbet-runtime'
require 'tmpdir'

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

      # Set an output for a GitHub Actions job.
      #
      # https://docs.github.com/en/actions/using-jobs/defining-outputs-for-jobs
      sig { params(name: String, value: String).void }
      def self.set_output(name:, value:)
        puts "::set-output name=#{name}::#{value}"
      end

      # Create an expandable log group in GitHub Actions job logs.
      #
      # https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#grouping-log-lines
      sig do
        type_parameters(:U)
          .params(group: String, blk: T.proc.returns(T.type_parameter(:U)))
          .returns(T.type_parameter(:U))
      end
      def self.log_group(group, &blk)
        puts "::group::#{group}"
        begin
          blk.call
        ensure
          puts '::endgroup::'
        end
      end

      # Retry a block the given number of times with rudimentary backoff.
      sig do
        type_parameters(:U)
          .params(times: Integer, blk: T.proc.returns(T.type_parameter(:U)))
          .returns(T.type_parameter(:U))
      end
      def self.retry_with(times:, &blk)
        backoff = 5

        begin
          blk.call
        rescue StandardError => e
          puts "Error during processing: #{e.class}: #{e}"
          backtrace = e.backtrace
          puts "Backtrace:\n\t#{backtrace.join("\n\t")}" unless backtrace.nil?

          times -= 1
          raise if times.zero?

          puts "Backing off for #{backoff}s before retrying ..."

          sleep(backoff)
          backoff *= 2

          puts 'Retrying ...'

          retry
        end
      end

      # Make temporary directory to install `cargo-about` binaries to.
      #
      # If running on GitHub Actions, use the `RUNNER_TEMP` directory.
      #
      # `RUNNER_TEMP` is the path to a temporary directory on the runner.
      # This directory is emptied at the beginning and end of each job.
      sig { returns(String) }
      def self.temp_dir
        temp_dir = ENV.fetch('RUNNER_TEMP') do
          Dir.mktmpdir(['generate_third_party', SecureRandom.hex])
        end
        destination = File.join(temp_dir, 'cargo-about-bin')
        FileUtils.mkdir_p(destination)
        destination
      end

      sig { params(path: String).void }
      def self.add_to_github_actions_runner_path(path)
        path_file = ENV.fetch('GITHUB_PATH', nil)
        return if path_file.nil?

        File.open(path_file, 'a') do |f|
          f.puts path
        end
      end
    end
  end
end
