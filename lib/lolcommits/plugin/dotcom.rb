# frozen_string_literal: true

require "rest-client"
require "lolcommits/plugin/base"

module Lolcommits
  module Plugin
    class Dotcom < Base
      BASE_URL = "https://lolcommits.com".freeze

      ##
      # Initialize plugin with runner, config and set all configurable options.
      #
      def initialize(runner: nil, name: nil, config: nil)
        super
        options.concat(plugin_options)
      end

      ##
      # Returns true/false indicating if the plugin has been correctly
      # configured. All options must be set with 32 character alphanumeric keys.
      #
      # @return [Boolean] true/false indicating if plugin is correctly
      # configured
      #
      def valid_configuration?
        plugin_options.all? do |option|
          configuration[option] =~ /^([a-z]|[0-9]){32}$/
        end
      end

      ##
      # Post-capture hook, runs after lolcommits captures a snapshot. Uploads
      # the lolcommit to the dot-com server with the following multi-part POST
      # body params (JSON encoded):
      #
      # `t` - timestamp, seconds since epoch
      # `token` - hex digest of `api_secret` from plugin config and timestamp
      # `key` - `api_key` from plugin config
      # `git_commit` - a hash with these params:
      #
      #   `sha` - the commit sha
      #   `repo_external_id` - the `repo_id` from plugin config
      #   `image` - the lolcommit image file (processed)
      #
      # @return [HTTParty::Response] response object from POST request
      # @return [Nil] if any error occurs
      #
      def run_capture_ready
        debug "Posting capture to #{BASE_URL}"
        t = Time.now.to_i.to_s

        RestClient.post(
          "#{BASE_URL}/git_commits.json",
          {
            git_commit: {
              sha: runner.sha,
              repo_external_id: configuration[:repo_id],
              image: File.open(runner.lolcommit_path)
            },
            key: configuration[:api_key],
            t: t,
            token: Digest::SHA1.hexdigest(configuration[:api_secret] + t)
          }
        )
      rescue => e
        log_error(e, "ERROR: HTTParty POST FAILED #{e.class} - #{e.message}")
        nil
      end


      private

      ##
      # Returns all configuration options available for this plugin.
      #
      # @return [Array] the option names
      #
      def plugin_options
        [ :api_key, :api_secret, :repo_id ]
      end
    end
  end
end
