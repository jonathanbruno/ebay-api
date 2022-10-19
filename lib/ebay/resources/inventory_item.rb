module Ebay
  class InventoryItem < Resource
    include Ebay::ResourceActions.new uri: 'sell/inventory/v1/inventory_item/%s'

    def self.all(params)
      params[:limit] ||= 10
      params[:offset] ||= 0
      get path.build, params
    end

    def self.create_or_replace(resource_id, params = {})
      put path.build(resource_id), params
    end

    def self.bulk_create_or_replace(params = {})
      post 'sell/inventory/v1/bulk_create_or_replace_inventory_item', params
    end

    def self.bulk_update_price_quantity(params = {})
      post 'sell/inventory/v1/bulk_update_price_quantity', params
    end
  end
end
