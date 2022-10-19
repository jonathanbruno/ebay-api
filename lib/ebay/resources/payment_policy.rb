module Ebay
  class PaymentPolicy < Resource
    include Ebay::ResourceActions.new uri: 'sell/account/v1/payment_policy/%s'

    def self.all(params)
      params[:limit] ||= 10
      params[:offset] ||= 0
      get path.build, params
    end
  end
end
