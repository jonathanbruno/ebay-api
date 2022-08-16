module Ebay
  class HttpError < StandardError
    attr_accessor :response_headers
    def initialize(headers)
      @response_headers = headers
    end
  end

  class BadRequest < HttpError; end
  class Unauthorized < HttpError; end
  class Forbidden < HttpError; end
  class NotFound < HttpError; end
  class MethodNotAllowed < HttpError; end
  class NotAccepted < HttpError; end
  class TimeOut < HttpError; end
  class ResourceConflict < HttpError; end
  class TooManyRequests < HttpError; end
  class InternalServerError < HttpError; end
  class BadGateway < HttpError; end
  class ServiceUnavailable < HttpError; end
  class GatewayTimeout < HttpError; end
  class BandwidthLimitExceeded < HttpError; end

  module HttpErrors
    ERRORS = {
      400 => Ebay::BadRequest,
      401 => Ebay::Unauthorized,
      403 => Ebay::Forbidden,
      404 => Ebay::NotFound,
      405 => Ebay::MethodNotAllowed,
      406 => Ebay::NotAccepted,
      408 => Ebay::TimeOut,
      409 => Ebay::ResourceConflict,
      422 => Ebay::ResourceConflict,
      429 => Ebay::TooManyRequests,
      500 => Ebay::InternalServerError,
      502 => Ebay::BadGateway,
      503 => Ebay::ServiceUnavailable,
      504 => Ebay::GatewayTimeout,
      509 => Ebay::BandwidthLimitExceeded
    }.freeze

    def throw_http_exception!(code, env)
      return unless ERRORS.keys.include? code
      response_headers = {}
      unless env.body.empty?
        response_headers = begin
          JSON.parse(env.body, symbolize_names: true)
        rescue StandardError
          {}
        end
      end
      unless env[:response_headers] && env[:response_headers]['X-Retry-After'].nil?
        response_headers[:retry_after] = env[:response_headers]['X-Retry-After'].to_i
      end
      raise ERRORS[code].new(response_headers), env.body
    end
  end
end
