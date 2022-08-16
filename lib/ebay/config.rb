module Ebay
  class Config < Hashie::Mash
    DEFAULTS = {
      base_url: 'https://api.sandbox.ebay.com'
    }.freeze

    def api_url
      DEFAULTS[:base_url]
    end
  end
end
