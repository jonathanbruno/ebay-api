module Ebay
  module Connection
    HEADERS = {
      'accept' => 'application/json',
      'content-type' => 'application/json',
      'user-agent' => 'ebay-api',
      'accept-encoding' => 'gzip',
      'Content-Language' => 'en-US'
    }.freeze

    def self.build(params)
      config = Ebay::Config.new(params)
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
  end
end
