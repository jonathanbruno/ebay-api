module Ebay
  class Collection < Resource
    include Ebay::ResourceActions.new(
      uri: 'stores/v1/collections/%s',
      disable: [:destroy_all, :destroy]
    )

    def self.add_products(resource_id, params = {})
      post "#{path.build(resource_id)}/productIds", params
    end
  end
end
