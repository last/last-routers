require "last/routers/path"

module Last
module Routers

class Route
  attr_reader :method
  attr_reader :path
  attr_reader :endpoint
  attr_reader :version

  def initialize(method, path, endpoint, version:)
    @method   = method
    @path     = Path.new(path)
    @endpoint = endpoint
    @version  = version
  end
end

end
end
