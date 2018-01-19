require "test_helper"
require 'webmock/minitest'

describe Lolcommits::Plugin::Dotcom do

  include Lolcommits::TestHelpers::GitRepo
  include Lolcommits::TestHelpers::FakeIO

  def plugin_name
    "dotcom"
  end

  it "should have a name" do
    ::Lolcommits::Plugin::Dotcom.name.must_equal plugin_name
  end

  it "should run on capture ready" do
    ::Lolcommits::Plugin::Dotcom.runner_order.must_equal [:capture_ready]
  end

  describe "with a runner" do
    def runner
      # a simple lolcommits runner with an empty configuration Hash
      @runner ||= Lolcommits::Runner.new(
        main_image: Tempfile.new('main_image.jpg'),
        snapshot_loc: Tempfile.new('snapshot_loc.jpg'),
        config: OpenStruct.new(
          read_configuration: {},
          loldir: File.expand_path("#{__dir__}../../../images")
        )
      )
    end

    def plugin
      @plugin ||= Lolcommits::Plugin::Dotcom.new(runner: runner)
    end

    def valid_enabled_config
      @config ||= OpenStruct.new(
        read_configuration: {
          "dotcom" => {
            "enabled" => true,
            "api_key"    => 'aaa8e2404ef6013556db5a9828apikey',
            'api_secret' => 'aaa8e2404ef6013556db5a9apisecret',
            "repo_id"    => "aaa8e2404ef6013556db5a9828repoid"
          }
        }
      )
    end

    describe "initalizing" do
      it "assigns runner and all plugin options" do
        plugin.runner.must_equal runner
        plugin.options.must_equal %w(
          enabled
          api_key
          api_secret
          repo_id
        )
      end
    end

    describe "#enabled?" do
      it "is false by default" do
        plugin.enabled?.must_equal false
      end

      it "is true when configured" do
        plugin.config = valid_enabled_config
        plugin.enabled?.must_equal true
      end
    end

    describe "run_capture_ready" do
      before { commit_repo_with_message("first commit!") }
      after { teardown_repo }

      it "uploads lolcommits to dot com server endpoint" do
        in_repo do
          plugin.config = valid_enabled_config
          stub_request(:post, /^http\:\/\/lolcommits-dot-com.herokuapp.com/).to_return(status: 200)

          plugin.run_capture_ready

          assert_requested :post,
            "http://lolcommits-dot-com.herokuapp.com/git_commits.json",
            times: 1,
            headers: {'Content-Type' => /multipart\/form-data/ } do |req|
              req.body.must_match 'name="git_commit[sha]"'
              req.body.must_match 'name="git_commit[repo_external_id]"'
              req.body.must_match /Content-Disposition: form-data;.+name="git_commit\[image\]"; filename="main_image.jpg.+"/
              req.body.must_match /Content-Disposition: form-data;.+name="git_commit\[raw\]"; filename="snapshot_loc.jpg.+"/
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
      it "returns false when not configured" do
        plugin.configured?.must_equal false
      end

      it "returns true when configured" do
        plugin.config = valid_enabled_config
        plugin.configured?.must_equal true
      end

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
          "enabled" => true,
          "api_key" => "aaa8e2404ef6013556db5a9828apikey",
          "api_secret" => "aaa8e2404ef6013556db5a9apisecret",
          "repo_id" => "aaa8e2404ef6013556db5a9828repoid"
        })
      end

      describe "#valid_configuration?" do
        it "returns false for an invalid configuration" do
          plugin.config = OpenStruct.new(read_configuration: {
            "dotcom" => { "repo_id" => "gibberish" }
          })
          plugin.valid_configuration?.must_equal false
        end

        it "returns true with a valid configuration" do
          plugin.config = valid_enabled_config
          plugin.valid_configuration?.must_equal true
        end
      end
    end
  end
end