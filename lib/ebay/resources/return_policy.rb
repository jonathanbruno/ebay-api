module Ebay
  class ReturnPolicy < Resource
    include Ebay::ResourceActions.new uri: 'sell/account/v1/return_policy/%s'

    def self.all(params)
      params[:limit] ||= 10
      params[:offset] ||= 0
      get path.build, params
    end
  end
end
