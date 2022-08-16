require 'ebay/request'
require 'ebay/resource_actions'
require 'ebay/subresource_actions'

module Ebay
  class Resource < Hashie::Mash
    include Hashie::Extensions::MethodAccess
    include Hashie::Extensions::IgnoreUndeclared
  end
end
