require 'hashie'
require 'faraday_middleware'
require 'ebay/version'
require 'ebay/config'
require 'ebay/connection'
require 'ebay/connection_manager'
require 'ebay/middleware/auth'
require 'ebay/middleware/http_exception'
require 'ebay/resources/resource'

module Ebay
  resources = File.join(File.dirname(__FILE__), 'ebay', 'resources', '**', '*.rb')
  Dir.glob(resources, &method(:require))

  class << self
    attr_reader :api, :config

    def configure
      @config = Ebay::Config.new.tap { |h| yield(h) }
      @api = Ebay::Connection.build(@config)
    end
  end
end
