require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    VCR.use_cassette("application_controller_test") do
      get root_url
      assert_response :success
    end
  end

  test "should filter by hotel id" do
    VCR.use_cassette("application_controller_test") do
      get root_url, params: {hotel_ids: ["iJhz"]}
      assert_response :success
      data = JSON.parse(response.body)
      assert_equal 1, data.size
      assert_equal "iJhz", data.first["id"]
      assert_equal 5432, data.first["destination_id"]
    end
  end

  test "should filter by destination id" do
    VCR.use_cassette("application_controller_test") do
      get root_url, params: {destination_ids: [5432]}
      assert_response :success
      data = JSON.parse(response.body)
      assert_equal 2, data.size
      assert_equal 5432, data.first["destination_id"]
      assert_equal 5432, data.second["destination_id"]
    end
  end
end
