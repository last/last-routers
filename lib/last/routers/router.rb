require "last/routers/request"
require "last/routers/route"

module Last
module Routers

class Router
  def call(env)
    Request.new(env, self.class).response or [404, {}, []]
  end

private

  class << self
    attr_accessor :routes
  end

  def self.inherited(subclass)
    subclass.routes = routes.dup unless routes.nil?
  end

  def self.route(*arguments, **options)
    arguments.unshift(__callee__)
    store_route(Routers::Route.new(*arguments, version: options.fetch(:version, default_version)))
  end

  def self.store_route(route)
    (@routes ||= []) << route
  end

  def self.set_default_version(version)
    @default_version = version
  end

  def self.default_version
    @default_version || 1
  end

  class << self
    alias_method :delete, :route
    alias_method :get,    :route
    alias_method :patch,  :route
    alias_method :post,   :route
    alias_method :put,    :route
  end
end

end
end
