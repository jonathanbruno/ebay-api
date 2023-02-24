module Ebay
  class Order < Resource
    include Ebay::ResourceActions.new uri: 'sell/fulfillment/v1/order/%s'

    def self.all(params)
      byebug
      params[:limit] ||= 10
      params[:offset] ||= 0
      get path.build, params
    end
  end
end
