module Ebay
  class ConnectionManager
    HEADERS = {
      'accept' => 'application/json',
      'content-type' => 'application/json',
      'user-agent' => 'ebay-api',
      'Content-Language' => 'en-US'
    }.freeze

    CONTENT_LANG_FOR_MARKETPLACE = {
      EBAY_US: 'en-US',
      EBAY_AT: 'de-AT',
      EBAY_AU: 'en-AU',
      EBAY_BE: 'nl-BE',
      EBAY_CA: 'en-CA',
      EBAY_CH: 'de-CH',
      EBAY_DE: 'de-DE',
      EBAY_ES: 'es-ES',
      EBAY_FR: 'fr-FR',
      EBAY_GB: 'en-GB',
      EBAY_HK: 'zh-HK',
      EBAY_IE: 'en-IE',
      EBAY_IN: 'en-GB',
      EBAY_IT: 'it-IT',
      EBAY_MY: 'en-US',
      EBAY_NL: 'nl-NL',
      EBAY_PH: 'en-PH',
      EBAY_PL: 'pl-PL',
      EBAY_SG: 'en-US',
      EBAY_TH: 'th-TH',
      EBAY_TW: 'zh-TW',
      EBAY_VN: 'en-US',
      EBAY_MOTORS_US: 'en-US'
    }

    def initialize(params)
      @params = params
    end

    def build_connection
      config = build_config
      ssl_options = config.ssl || {}
      Faraday.new(url: config.api_url, ssl: ssl_options) do |conn|
        conn.request :json
        conn.headers = HEADERS.merge(
          'Content-Language' => content_language_for(config.marketplace_id)
        )
        conn.use Ebay::Middleware::Auth, config
        conn.use Ebay::Middleware::HttpException
        conn.use FaradayMiddleware::Gzip
        conn.adapter Faraday.default_adapter
      end
    end

    def refresh_token
      config = build_config
      faraday = Faraday.new(url: config.api_url) do |conn|
        base64_auth = Base64.strict_encode64("#{ENV['EBAY_APP_ID']}:#{ENV['EBAY_APP_SECRET']}")
        conn.request :url_encoded
        conn.headers = HEADERS.merge(
          'content-type' => 'application/x-www-form-urlencoded',
          'Authorization' => "Basic #{base64_auth}",
          'Content-Language' => content_language_for(config.marketplace_id)
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

    def build_config
      Ebay::Config.new(token: @params[:token]).tap do |config|
        prefix = @params[:apiz] ? 'apiz' : 'api'
        config.custom_api_url =
          if @params[:sandbox]
            "https://#{prefix}.sandbox.ebay.com"
          else
            "https://#{prefix}.ebay.com"
          end
        config.marketplace_id = @params[:marketplace_id]
      end
    end

    def content_language_for(marketplace_id)
      CONTENT_LANG_FOR_MARKETPLACE[marketplace_id] || 'en-US'
    end
  end
end
