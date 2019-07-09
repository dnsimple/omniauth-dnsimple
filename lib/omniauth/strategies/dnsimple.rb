require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Dnsimple < OmniAuth::Strategies::OAuth2
      CLIENT_OPTIONS = {
        production: {
          site: 'https://api.dnsimple.com',
          authorize_url: 'https://dnsimple.com/oauth/authorize',
          token_url: 'https://api.dnsimple.com/v2/oauth/access_token',
        },
        sandbox: {
          site: 'https://api.sandbox.dnsimple.com',
          authorize_url: 'https://sandbox.dnsimple.com/oauth/authorize',
          token_url: 'https://api.sandbox.dnsimple.com/v2/oauth/access_token',
        },
      }.freeze

      option :name, 'dnsimple'

      option :client_options,
             site: CLIENT_OPTIONS[:production][:site],
             authorize_url: CLIENT_OPTIONS[:production][:authorize_url],
             token_url: CLIENT_OPTIONS[:production][:token_url]

      uid do
        raw_info.fetch('id')
      end

      info do
        {
          type: raw_info['type'],
          email: raw_info['email'],
          plan_identifier: raw_info['plan_identifier'],
        }
      end

      extra do
        {
          'raw_info' => raw_info,
        }
      end

      def initialize(app, *args, &block)
        super
        return unless sandbox?(args)

        options.client_options.site          = CLIENT_OPTIONS[:sandbox][:site]
        options.client_options.authorize_url = CLIENT_OPTIONS[:sandbox][:authorize_url]
        options.client_options.token_url     = CLIENT_OPTIONS[:sandbox][:token_url]
      end

      def callback_url
        full_host + script_name + callback_path
      end

      def raw_info
        @raw_info ||= begin
          data = JSON.parse(
              access_token.get('/v2/whoami').body
            )['data']

          if data.key?('user') && !data['user'].nil?
            data['user'].merge('type' => 'user')
          else
            data['account'].merge('type' => 'account')
          end
        end
      end

      protected

      def sandbox?(args)
        opts = args.last
        opts && [true, "true"].include?(opts[:sandbox])
      end

      def build_access_token
        verifier = request.params['code']
        params   = { redirect_uri: callback_url,
                     state: request.params['state'], }
            .merge(token_params.to_hash(symbolize_keys: true))

        client.auth_code.get_token(verifier, params,
                                   deep_symbolize(options.auth_token_params))
      end
    end
  end
end
