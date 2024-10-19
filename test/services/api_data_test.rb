require "test_helper"

class ApiDataTest < ActiveSupport::TestCase
  def test_get_merged_data
    api3_json = ActiveSupport::JSON.decode(File.read(Rails.root.join("test/fixtures/files/api3.json")))
    VCR.use_cassette("api_data_test") do
      api_data = ApiData.new
      merged_data = api_data.get_merged_data
      assert_equal 3, merged_data.size
      response = merged_data.first
      assert response.valid?
      assert_equal "iJhz", response.id
      assert_equal 5432, response.destination_id
      assert_equal "Beach Villas Singapore", response.name
      assert_equal api3_json[0]["details"], response.description
      assert_equal api3_json[0]["booking_conditions"], response.booking_conditions
      assert response.location.valid?
      assert_equal 1.264751, response.location.lat
      assert_equal 103.824006, response.location.lng
      assert_equal "8 Sentosa Gateway, Beach Villas, 098269", response.location.address
      assert_equal "Singapore", response.location.country
      assert_equal "Singapore", response.location.city
      assert response.amenities.valid?
      assert_equal ["outdoor pool", "indoor pool", "business center", "childcare", "wifi", "dry cleaning", "breakfast"], response.amenities.general
      assert_equal ["aircon", "tv", "coffee machine", "kettle", "hair dryer", "iron", "tub"], response.amenities.room
      assert response.images.valid?
      assert_equal "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg", response.images.rooms.first.link
      assert_equal "Double room", response.images.rooms.first.description
      assert_equal "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/3.jpg", response.images.rooms.second.link
      assert_equal "Double room", response.images.rooms.second.description
      assert_equal "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg", response.images.rooms.third.link
      assert_equal "Bathroom", response.images.rooms.third.description
      assert_equal "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg", response.images.site.first.link
      assert_equal "Front", response.images.site.first.description
      assert_equal "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/0.jpg", response.images.amenities.first.link
      assert_equal "RWS", response.images.amenities.first.description
      assert_equal "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/6.jpg", response.images.amenities.second.link
      assert_equal "Sentosa Gateway", response.images.amenities.second.description
    end
  end
end
