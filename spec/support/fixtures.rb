class FakeEndpoint
  def call(environment)
    [200, {}, self.class.to_s]
  end
end

class FakeRootEndpointV2 < FakeEndpoint; end
class FakeListEndpointV2 < FakeEndpoint; end
class FakeReadEndpointV2 < FakeEndpoint; end
class FakeReadEndpointV3 < FakeEndpoint; end

class FakeDeleteEndpoint < FakeEndpoint; end
class FakePatchEndpoint  < FakeEndpoint; end
class FakePostEndpoint   < FakeEndpoint; end
class FakePutEndpoint    < FakeEndpoint; end

class FakeRouter < Last::Routers::Router
  set_default_version 2

  get "/",          FakeRootEndpointV2, version: 2
  get "/tests",     FakeListEndpointV2, version: 2
  get "/tests/:id", FakeReadEndpointV2, version: 2
  get "/tests/:id", FakeReadEndpointV3, version: 3

  delete "/", FakeDeleteEndpoint, version: 2
  patch  "/", FakePatchEndpoint,  version: 2
  post   "/", FakePostEndpoint,   version: 2
  put    "/", FakePutEndpoint,    version: 2
end
