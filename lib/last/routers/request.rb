require "rack"

module Last
module Routers

class Request
  def initialize(env, router)
    @env     = env
    @router  = router

    @request = Rack::Request.new(env)
    @method  = env["REQUEST_METHOD"].downcase.to_sym
    @path    = env["PATH_INFO"].to_s
    @version = Integer(accept_version || router.default_version)

    set_matching_route_for_path
  end

  # @return [Array] rack response if route was matched for request
  # @return [nil]   if route was not matched for request
  #
  def response
    route ? route.endpoint.new.call(env) : nil
  end

private

  attr_reader :env
  attr_reader :router

  attr_reader :request
  attr_reader :method
  attr_reader :path
  attr_reader :version

  attr_accessor :route
  attr_reader   :match

  def accept_version
    env["HTTP_ACCEPT"] ? env["HTTP_ACCEPT"][/version=(\d)/, 1] : nil
  end

  def set_matching_route_for_path
    match = nil

    @route = router.routes.find do |route|
      route.method  == method &&
      route.version == version &&
      match          = route.path.match(path)
    end

    update_params_with_matched_path_fragments(match) if match
  end

  def update_params_with_matched_path_fragments(match)
    [match.names, match.captures].transpose.each do |key, value|
      request.update_param(key, value)
    end
  end
end

end
end
