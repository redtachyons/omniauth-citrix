require "test_helper"

class ClientOptionsTest < Minitest::Test
  let(:app) { -> env {} }

  let(:strategy) do
    OmniAuth::Strategies::Citrix.new(app, "consumer_id", "consumer_secret")
  end

  test "sets name" do
    assert_equal "citrix", strategy.options.name
  end

  test "sets authorize url" do
    assert_equal "https://api.citrixonline.com/oauth/authorize", strategy.options.client_options.authorize_url
  end

  test "sets token url" do
    assert_equal "https://api.citrixonline.com/oauth/access_token", strategy.options.client_options.token_url
  end

  test "ignores state" do
    assert strategy.options.provider_ignores_state
  end
end
