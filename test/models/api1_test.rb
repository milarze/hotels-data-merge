require "test_helper"

class Api1Test < ActiveSupport::TestCase
  def test_from_json
    json = ActiveSupport::JSON.decode(File.read(Rails.root.join("test/fixtures/files/api1.json")))[0]
    api1 = ::Api1.from_json(json)
    assert_equal "iJhz", api1.id
    assert_equal 5432, api1.destination
    assert_equal "Beach Villas Singapore", api1.name
    assert_equal 1.264751, api1.latitude
    assert_equal 103.824006, api1.longitude
    assert_equal " 8 Sentosa Gateway, Beach Villas ", api1.address
    assert_equal "Singapore", api1.city
    assert_equal "SG", api1.country
    assert_equal "098269", api1.postal_code
    assert_equal "  This 5 star hotel is located on the coastline of Singapore.", api1.description
    assert_equal ["Pool", "BusinessCenter", "WiFi ", "DryCleaning", " Breakfast"], api1.facilities
  end
end
