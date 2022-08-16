module Ebay
  class Order < Resource
    include Ebay::ResourceActions.new uri: 'stores/v2/orders/%s'
  end
end
