module Ebay
  class Trading < Resource
    include Ebay::ResourceActions.new uri: 'ws/api.dll'

    def self.set_notification(marketplace_code, api_call_name, params = {})
      client = params.delete(:connection)
      client.post do |request|
        request.url path.build
        request.body = params[:body]
        request.headers = {
          "X-EBAY-API-SITEID" => marketplace_code.to_s,
          "X-EBAY-API-COMPATIBILITY-LEVEL" => "967",
          "X-EBAY-API-CALL-NAME" => api_call_name
        }
      end
    end
  end
end
