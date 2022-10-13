module Ebay
  class Offer < Resource
    include Ebay::ResourceActions.new uri: 'sell/inventory/v1/offer/%s'

    def self.all(params)
      params[:limit] ||= 10
      params[:offset] ||= 0
      get path.build, params
    end

    def self.publish(resource_id, params = {})
      post "#{path.build(resource_id)}/publish", params
    end

    def self.bulk_create_or_replace(params = {})
      post 'sell/inventory/v1/bulk_create_offer', params
    end

    def self.publish_by_inventory_item_group(params = {})
      post 'sell/inventory/v1/offer/publish_by_inventory_item_group', params
    end
  end
end
