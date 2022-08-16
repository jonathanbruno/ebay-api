module Ebay
  class ProductMedia < Resource
    include Ebay::SubresourceActions.new uri: 'stores/v1/products/%s/media/%s'
  end
end
