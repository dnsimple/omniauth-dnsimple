require "securerandom"
require "omniauth"

module OmniAuth
  module Dnsimple
    module RSpec
      def self.included(spec)
        spec.class_eval do
          let(:successful_params) do
            Hash[
              type: "account",
              plan_identifier: "dnsimple-professional",
              uid: Random.rand(10_000_000),
              email: "user@#{SecureRandom.uuid}.test",
              token: SecureRandom.hex(32),
            ]
          end
        end
      end

      private

      PROVIDER = :dnsimple

      def omniauth_successful_signup
        params = Hash[
          "omniauth.auth" => {
            "provider" => PROVIDER.to_s,
            "uid" => successful_params.fetch(:uid),
            "info" => {
              "type" => successful_params.fetch(:type),
              "plan_identifier" => successful_params.fetch(:plan_identifier),
              "email" => successful_params.fetch(:email),
            },
            "credentials" => {
              "token" => successful_params.fetch(:token),
            },
          }
        ]

        ::OmniAuth::AuthHash.new(params.fetch("omniauth.auth")).tap do |data|
          omniauth_mock_auth data
        end
      end

      def omniauth_failing_signup
        omniauth_mock_auth :invalid_credentials
      end

      def omniauth_mock_auth(data)
        ::OmniAuth.config.mock_auth[PROVIDER] = data
      end
    end
  end
end

RSpec.configure do |config|
  config.include(OmniAuth::Dnsimple::RSpec)
end

OmniAuth.config.test_mode = true
