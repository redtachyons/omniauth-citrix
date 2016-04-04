require "test_helper"

class AuthorizeParamsTest < Minitest::Test
  let(:app) { -> env {} }

  let(:strategy) do
    OmniAuth::Strategies::Citrix.new(app, "consumer_id", "consumer_secret")
  end

  test "includes client id" do
    assert_equal "consumer_id", strategy.authorize_params[:client_id]
  end
end
