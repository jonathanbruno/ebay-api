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

    def self.get_order(marketplace_code, order_id, params = {})
      client = params.delete(:connection)
      client.post do |request|
        request.url path.build
        request.body = <<-XML
          <?xml version="1.0" encoding="utf-8"?>
          <GetOrdersRequest xmlns="urn:ebay:apis:eBLBaseComponents">
            <RequesterCredentials>
              <eBayAuthToken>#{params[:token]}</eBayAuthToken>
            </RequesterCredentials>
            <ErrorLanguage>en_US</ErrorLanguage>
            <WarningLevel>High</WarningLevel>
            <OrderIDArray>
              <OrderID>#{order_id}</OrderID>
            </OrderIDArray>
            <OrderRole>Seller</OrderRole>
          </GetOrdersRequest>
        XML
        request.headers = {
          "X-EBAY-API-SITEID" => marketplace_code.to_s,
          "X-EBAY-API-COMPATIBILITY-LEVEL" => "967",
          "X-EBAY-API-CALL-NAME" => 'GetOrders'
        }
      end
    end
  end
end
