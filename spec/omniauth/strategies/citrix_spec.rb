require 'spec_helper'

describe OmniAuth::Strategies::Citrix do
  let(:app) { -> env {} }

  subject(:strategy) do
    OmniAuth::Strategies::Citrix.new(app, 'consumer_id', 'consumer_secret')
  end

  describe 'client options' do
    it 'sets name' do
      expect(strategy.options.name).to eq('citrix')
    end

    it 'sets authorize url' do
      expect(strategy.options.client_options.authorize_url).to eq('https://api.citrixonline.com/oauth/authorize')
    end

    it 'sets token url' do
      expect(strategy.options.client_options.token_url).to eq('https://api.citrixonline.com/oauth/access_token')
    end

    it 'ignores state' do
      expect(strategy.options.provider_ignores_state).to be_truthy
    end
  end

  describe '#authorize_params' do
    it 'includes client id' do
      expect(strategy.authorize_params).to include(client_id: 'consumer_id')
    end
  end

  describe '#token_params' do
    before do
      request = double('request', params: {'code' => 'CODE'})
      allow(strategy).to receive(:request).and_return(request)
    end

    it 'sets grant type' do
      expect(strategy.token_params).to include(grant_type: 'authorization_code')
    end

    it 'sets code' do
      expect(strategy.token_params).to include(code: 'CODE')
    end

    it 'sets client id' do
      expect(strategy.token_params).to include(client_id: 'consumer_id')
    end
  end

  describe '#uid' do
    before do
      access_token = double('access_token', {params: {
        'account_key' => 'ACCOUNT_KEY'
      }})

      allow(strategy).to receive(:access_token).and_return(access_token)
    end

    it 'returns uid' do
      expect(strategy.uid).to eq('ACCOUNT_KEY')
    end
  end

  describe '#info' do
    before do
      access_token = double('access_token', {params: {
        'account_key' => 'ACCOUNT_KEY',
        'organizer_key' => 'ORGANIZER_KEY',
        'firstName' => 'FIRST_NAME',
        'lastName' => 'LAST_NAME',
        'account_type' => 'ACCOUNT_TYPE',
        'email' => 'EMAIL',
        'platform' => 'PLATFORM'
      }})

      allow(strategy).to receive(:access_token).and_return(access_token)
    end

    it { expect(strategy.info[:account_key]).to eq('ACCOUNT_KEY') }
    it { expect(strategy.info[:organizer_key]).to eq('ORGANIZER_KEY') }
    it { expect(strategy.info[:first_name]).to eq('FIRST_NAME') }
    it { expect(strategy.info[:last_name]).to eq('LAST_NAME') }
    it { expect(strategy.info[:account_type]).to eq('ACCOUNT_TYPE') }
    it { expect(strategy.info[:email]).to eq('EMAIL') }
    it { expect(strategy.info[:platform]).to eq('PLATFORM') }
  end
end
