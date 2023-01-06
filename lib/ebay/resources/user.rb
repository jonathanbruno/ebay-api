module Ebay
  class User < Resource
    include Ebay::ResourceActions.new uri: 'commerce/identity/v1/user/'

    def self.find(params)
      get path.build, params
    end
  end
end
