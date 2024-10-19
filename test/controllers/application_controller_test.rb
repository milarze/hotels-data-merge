require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    VCR.use_cassette("application_controller_test") do
      get root_url
      assert_response :success
    end
  end
end
