module Ebay
  class ShippingFulfillment < Resource
    include SubresourceActions.new uri: 'sell/fulfillment/v1/order/%s/shipping_fulfillment'
  end
end
