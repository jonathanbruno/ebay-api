module Ebay
  class Inventory < Resource
    include Ebay::ResourceActions.new uri: 'sell/inventory/v1/inventory_item/%s'

    def self.all(params)
      params[:limit] ||= 10
      params[:offset] ||= 0
      get path.build, params
    end

    def self.create_or_update(resource_id, params = {})
      put path.build(resource_id), params
    end
  end
end
