require 'ebay/exception'

module Ebay
  module Middleware
    class HttpException < Faraday::Response::Middleware
      include Ebay::HttpErrors

      def on_complete(env)
        throw_http_exception! env[:status].to_i, env
        env
      end
    end
  end
end
