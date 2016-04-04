require "test_helper"

class InfoTest < Minitest::Test
  let(:app) { -> env {} }

  let(:strategy) do
    OmniAuth::Strategies::Citrix.new(app, "consumer_id", "consumer_secret")
  end

  test "returns info" do
    access_token = mock("access_token")

    access_token.stubs(:params).returns({
      "account_key" => "ACCOUNT_KEY",
      "organizer_key" => "ORGANIZER_KEY",
      "firstName" => "FIRST_NAME",
      "lastName" => "LAST_NAME",
      "account_type" => "ACCOUNT_TYPE",
      "email" => "EMAIL",
      "platform" => "PLATFORM"
    })
    strategy.stubs(:access_token).returns(access_token)

    info = strategy.info

    assert_equal 'ACCOUNT_KEY', info[:account_key]
    assert_equal 'ORGANIZER_KEY', info[:organizer_key]
    assert_equal 'FIRST_NAME', info[:first_name]
    assert_equal 'LAST_NAME', info[:last_name]
    assert_equal 'ACCOUNT_TYPE', info[:account_type]
    assert_equal 'EMAIL', info[:email]
    assert_equal 'PLATFORM', info[:platform]
  end
end
