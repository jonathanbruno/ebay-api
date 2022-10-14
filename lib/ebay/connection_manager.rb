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
      config = Ebay::Config.new(
        token: @params[:token]
      )
      faraday = Faraday.new(url: config.api_url) do |conn|
        base64_auth = Base64.strict_encode64("#{ENV['EBAY_APP_ID']}:#{ENV['EBAY_APP_SECRET']}")
        conn.request :url_encoded
        conn.headers = HEADERS.merge(
          'content-type' => 'application/x-www-form-urlencoded',
          'Authorization' => "Basic #{base64_auth}",
        )
        conn.use Ebay::Middleware::HttpException
        conn.adapter Faraday.default_adapter
      end
      response = faraday.run_request(
        :post,
        'identity/v1/oauth2/token',
        "grant_type=refresh_token&refresh_token=#{@params[:refresh_token]}&scope=#{@params[:scopes]}",
        {}
      )
      parsed = JSON.parse(response.body).deep_symbolize_keys
      @params[:token] = parsed[:access_token]
      @params[:refresh_token] = parsed[:refresh_token]
      parsed
    end
  end
end
