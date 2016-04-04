require "test_helper"

class TokenParamsTest < Minitest::Test
  let(:app) { -> env {} }

  let(:strategy) do
    OmniAuth::Strategies::Citrix.new(app, "consumer_id", "consumer_secret")
  end

  setup do
    request = mock("request", params: {"code" => "CODE"})
    strategy.stubs(:request).returns(request)
  end

  test "sets grant type" do
    assert_equal "authorization_code", strategy.token_params["grant_type"]
  end

  test "sets code" do
    assert_equal "CODE", strategy.token_params["code"]
  end

  test "sets client id" do
    assert_equal "consumer_id", strategy.token_params["client_id"]
  end
end
