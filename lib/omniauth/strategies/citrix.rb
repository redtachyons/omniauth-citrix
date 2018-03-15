require 'omniauth'
require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Citrix < OmniAuth::Strategies::OAuth2
      option :client_options,
             authorize_url: 'https://api.getgo.com/oauth/v2/authorize',
             token_url: 'https://api.getgo.com/oauth/v2/token'

      option :provider_ignores_state, true

      def authorize_params
        { client_id: client.id }
      end

      def token_params
        {
          'grant_type' => 'authorization_code',
          'code' => request.params['code'],
          'client_id' => client.id
        }
      end

      uid do
        access_token.params['account_key']
      end

      info do
        {
          organizer_key: access_token.params['organizer_key'],
          account_key: access_token.params['account_key'],
          account_type: access_token.params['account_type'],
          first_name: access_token.params['firstName'].strip,
          last_name: access_token.params['lastName'].strip,
          email: access_token.params['email'],
          platform: access_token.params['platform']
        }
      end

      def request_phase
        redirect client.auth_code.authorize_url(authorize_params)
      end

      protected

      def base64_auth
        'Basic ' + Base64.encode64("#{client.id}:#{client.secret}").delete("\n")
      end

      def build_access_token
        client.auth_code.get_token(request.params['code'],
                                   headers: { 'Authorization' => base64_auth },
                                   token_method: :post)
      end
    end
  end
end
