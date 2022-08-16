module Ebay
  class Variant < Resource
    include Ebay::SubresourceActions.new uri: 'stores/v1/products/%s/variants/%s'

    # override
    def self.bulk_update(parent_id, params = {})
      patch path.build(parent_id), params
    end
  end
end
