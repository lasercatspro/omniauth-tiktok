# frozen_string_literal: true

require 'omniauth/strategies/oauth2'
module OAuth2
  class Authenticator
    def apply(params)
      case mode.to_sym
      when :basic_auth
        apply_basic_auth(params)
      when :request_body
        apply_params_auth(params)
      when :tls_client_auth
        apply_client_id(params)
      when :private_key_jwt
        params
      when :tiktok_auth_sceme
        apply_tiktok_auth_scheme(params)
      else
        raise NotImplementedError
      end
    end

    def apply_tiktok_auth_scheme(params)
      result = {}
      result['client_secret'] = secret unless secret.nil?
      result.merge(params)
    end
  end
end
module OmniAuth
  module Strategies
    class Tiktok < OmniAuth::Strategies::OAuth2
      class NoAuthorizationCodeError < StandardError; end
      DEFAULT_SCOPE = 'user.info.basic,video.list'
      USER_INFO_URL = 'https://open.tiktokapis.com/v2/user/info/'

      option :name, 'tiktok'

      option :client_options, {
        site: 'https://open-api.tiktok.com',
        authorize_url: 'https://www.tiktok.com/v2/auth/authorize/',
        token_url: 'https://open.tiktokapis.com/v2/oauth/token/',
        auth_scheme: :tiktok_auth_sceme,
        extract_access_token: proc do |client, hash|
          ::OAuth2::AccessToken.from_hash(client, hash)
        end
      }

      option :authorize_options, %i[scope display auth_type]

      uid { access_token.params['open_id'] }

      info do
        prune!('username' => raw_info['username'])
      end

      extra do
        hash = {}
        hash['raw_info'] = raw_info unless skip_info?
        prune! hash
      end

      credentials do
        hash = {}
        hash['token'] = access_token.token
        hash['refresh_token'] = access_token.refresh_token if access_token.expires? && access_token.refresh_token
        hash['expires_at'] = access_token.expires_at if access_token.expires?
        hash['expires'] = access_token.expires?
        refresh_token_expires_at = Time.now.to_i + access_token.params['refresh_expires_in'].to_i
        hash['refresh_token_expires_at'] = refresh_token_expires_at
        hash
      end

      def raw_info
        @raw_info ||= access_token
                      .get("#{USER_INFO_URL}?fields=username")
                      .parsed&.dig('data', 'user') || {}
      end

      def callback_url
        options[:callback_url] || (full_host + script_name + callback_path)
      end

      def authorize_params
        super.tap do |params|
          params[:scope] ||= DEFAULT_SCOPE
          params[:response_type] = 'code'
          params.delete(:client_id)
          params[:client_key] = options.client_id
          options.client_id = nil
        end
      end

      def token_params
        super.tap do |params|
          params.delete(:client_id)
          params[:client_key] = options.client_id
          options.client_id = nil
        end
      end

      private

      def prune!(hash)
        hash.delete_if do |_, value|
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end
    end
  end
end
