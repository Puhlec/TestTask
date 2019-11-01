require 'test_helper'
class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "few requests" do
    get search_url, params: { q: "asdsd"}
    assert_response :success
    assert_match "Wrong URL", @response.body
    get search_url, params: { q: "github.com/rails/rails"}
    assert_match "tenderlove", @response.body
    assert_match "dhh", @response.body
    assert_match "jeremy", @response.body
    get search_url, params: { q: ""}
    assert_match "Wrong URL", @response.body
    get search_url, params: { q: "github.com/Puhlec/soulen"}
    assert_match "download zip (0)", @response.body
  end
end
