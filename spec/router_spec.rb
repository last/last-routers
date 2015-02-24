require_relative "spec_helper"

class TestRouter < Minitest::Test
  include Rack::Test::Methods

  def app
    FakeRouter.new
  end

  def test_not_found_request
    get "/404"
    assert last_response.status == 404
  end

  def test_root_request
    get "/"
    assert last_response.body == "FakeRootEndpointV2"
  end

  def test_list_request
    get "/tests"
    assert last_response.body == "FakeListEndpointV2"
  end

  def test_read_request
    get "/tests/1"
    assert last_response.body == "FakeReadEndpointV2"
  end

  def test_versioned_read_request
    header "Accept", "application/vnd.last+json; version=3"
    get "/tests/1"
    assert last_response.body == "FakeReadEndpointV3"
  end

  def test_delete_request
    delete "/"
    assert last_response.body == "FakeDeleteEndpoint"
  end

  def test_patch_request
    patch "/"
    assert last_response.body == "FakePatchEndpoint"
  end

  def test_post_request
    post "/"
    assert last_response.body == "FakePostEndpoint"
  end

  def test_put_request
    put "/"
    assert last_response.body == "FakePutEndpoint"
  end
end
