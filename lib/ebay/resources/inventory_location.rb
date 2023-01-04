module Ebay
  class InventoryLocation < Resource
    include Ebay::ResourceActions.new uri: 'sell/inventory/v1/location/%s'

    def self.all(params)
      params[:limit] ||= 10
      params[:offset] ||= 0
      get path.build, params
    end

    def self.create(merchant_location_key, params = {})
      post path.build(merchant_location_key), params
    end
  end
end
