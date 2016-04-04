require "test_helper"

class UidTest < Minitest::Test
  let(:app) { -> env {} }

  let(:strategy) do
    OmniAuth::Strategies::Citrix.new(app, "consumer_id", "consumer_secret")
  end

  test "returns uuid" do
    access_token = mock("access_token", {params: {
      "account_key" => "ACCOUNT_KEY"
    }})

    strategy.stubs(:access_token).returns(access_token)

    assert_equal "ACCOUNT_KEY", strategy.uid
  end
end
