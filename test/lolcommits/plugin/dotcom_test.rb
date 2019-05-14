# frozen_string_literal: true

require "test_helper"
require 'webmock/minitest'

describe Lolcommits::Plugin::Dotcom do

  include Lolcommits::TestHelpers::GitRepo
  include Lolcommits::TestHelpers::FakeIO

  describe "with a runner" do
    def runner
      # a simple lolcommits runner with an empty configuration Hash
      @runner ||= Lolcommits::Runner.new(
        lolcommit_path: Tempfile.new('lolcommit.jpg'),
      )
    end

    def plugin
      @plugin ||= Lolcommits::Plugin::Dotcom.new(runner: runner)
    end

    def valid_enabled_config
      {
        enabled: true,
        api_key: 'aaa8e2404ef6013556db5a9828apikey',
        api_secret: 'aaa8e2404ef6013556db5a9apisecret',
        repo_id: "aaa8e2404ef6013556db5a9828repoid"
      }
    end

    describe "initalizing" do
      it "assigns runner and all plugin options" do
        plugin.runner.must_equal runner
        plugin.options.must_equal [:enabled, :api_key, :api_secret, :repo_id]
      end
    end

    describe "#enabled?" do
      it "is false by default" do
        plugin.enabled?.must_equal false
      end

      it "is true when configured" do
        plugin.configuration = valid_enabled_config
        plugin.enabled?.must_equal true
      end
    end

    describe "run_capture_ready" do
      before { commit_repo_with_message("first commit!") }
      after { teardown_repo }

      it "uploads lolcommits to dot com server endpoint" do
        in_repo do
          plugin.configuration = valid_enabled_config
          stub_request(:post, /^https\:\/\/lolcommits.com/).to_return(status: 200)

          plugin.run_capture_ready

          assert_requested :post,
            "https://lolcommits.com/git_commits.json",
            times: 1,
            headers: {'Content-Type' => /multipart\/form-data/ } do |req|
              req.body.must_match 'name="git_commit[sha]"'
              req.body.must_match 'name="git_commit[repo_external_id]"'
              req.body.must_match(/Content-Disposition: form-data;.+name="git_commit\[image\]"; filename="lolcommit.jpg.+"/)
              req.body.must_match 'name="key"'
              req.body.must_match 'name="t"'
              req.body.must_match 'name="token"'
              req.body.must_match 'aaa8e2404ef6013556db5a9828apikey'
              req.body.must_match 'aaa8e2404ef6013556db5a9828repoid'
            end
        end
      end
    end

    describe "configuration" do
      it "allows plugin options to be configured" do
        # enabled, api_key, api_secret repo_id
        inputs = %w(
          true
          aaa8e2404ef6013556db5a9828apikey
          aaa8e2404ef6013556db5a9apisecret
          aaa8e2404ef6013556db5a9828repoid
        )
        configured_plugin_options = {}

        fake_io_capture(inputs: inputs) do
          configured_plugin_options = plugin.configure_options!
        end

        configured_plugin_options.must_equal({
          enabled: true,
          api_key: "aaa8e2404ef6013556db5a9828apikey",
          api_secret: "aaa8e2404ef6013556db5a9apisecret",
          repo_id: "aaa8e2404ef6013556db5a9828repoid"
        })
      end

      describe "#valid_configuration?" do
        it "returns false for an invalid configuration" do
          plugin.configuration = { repo_id: "gibberish" }
          plugin.valid_configuration?.must_equal false
        end

        it "returns true with a valid configuration" do
          plugin.configuration = valid_enabled_config
          plugin.valid_configuration?.must_equal true
        end
      end
    end
  end
end
