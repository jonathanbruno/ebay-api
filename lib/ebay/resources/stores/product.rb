module Ebay
  class Product < Resource
    include Ebay::ResourceActions.new uri: 'stores/v1/products/%s'
  end
end
