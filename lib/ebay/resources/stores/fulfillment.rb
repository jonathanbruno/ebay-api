module Ebay
  class Fulfillment < Resource
    include Ebay::SubresourceActions.new(
      uri: 'stores/v2/orders/%s/fulfillments/%s',
      disable: [:destroy_all, :all]
    )
  end
end
