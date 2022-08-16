module Ebay
  class ConnectionManager
    HEADERS = {
      'accept' => 'application/json',
      'content-type' => 'application/json',
      'user-agent' => 'ebay-api',
      'Content-Language' => 'en-US'
    }.freeze

    def initialize(params)
      @params = params
    end

    def build_connection
      config = Ebay::Config.new(
        token: @params[:token]
      )
      ssl_options = config.ssl || {}
      Faraday.new(url: config.api_url, ssl: ssl_options) do |conn|
        conn.request :json
        conn.headers = HEADERS
        conn.use Ebay::Middleware::Auth, config
        conn.use Ebay::Middleware::HttpException
        conn.use FaradayMiddleware::Gzip
        conn.adapter Faraday.default_adapter
      end
    end

    def refresh_token
      c = Faraday.new(url: config.api_url) do |conn|
        conn.request :json
        conn.headers = HEADERS
        conn.use Ebay::Middleware::HttpException
        conn.adapter Faraday.default_adapter
      end
      response = c.run_request(
        :post,
        'oauth/access',
        {
          grant_type: 'refresh_token',
          client_id: @params[:app_id],
          client_secret: @params[:app_secret],
          refresh_token: @params[:refresh_token]
        },
        {}
      )
      parsed = JSON.parse(response.body).deep_symbolize_keys
      @params[:token] = parsed[:access_token]
      @params[:refresh_token] = parsed[:refresh_token]
      parsed
    end
  end
end
