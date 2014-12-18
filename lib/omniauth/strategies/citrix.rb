require 'omniauth'
require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Citrix < OmniAuth::Strategies::OAuth2
      option :client_options, {
        authorize_url: 'https://api.citrixonline.com/oauth/authorize',
        token_url: 'https://api.citrixonline.com/oauth/access_token'
      }

      option :provider_ignores_state, true

      def authorize_params
        {client_id: client.id}
      end

      def token_params
        {
          grant_type: 'authorization_code',
          code: request.params['code'],
          client_id: client.id
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

      protected

      def build_access_token
        client.auth_code.get_token(
          request.params['code'],
          {redirect_uri: callback_url}.merge(token_params),
          deep_symbolize(options.auth_token_params)
        )
      end
    end
  end
end
