require "test_helper"

class Api2Test < ActiveSupport::TestCase
  def test_from_json
    json = {
      "id" => "iJhz",
      "destination" => 5432,
      "name" => "Beach Villas Singapore",
      "lat" => 1.264751,
      "lng" => 103.824006,
      "address" => "8 Sentosa Gateway, Beach Villas, 098269",
      "info" =>
   "Located at the western tip of Resorts World Sentosa, guests at the Beach Villas are guaranteed privacy while they enjoy spectacular views of glittering waters. Guests will find themselves in paradise with this series of exquisite tropical sanctuaries, making it the perfect setting for an idyllic retreat. Within each villa, guests will discover living areas and bedrooms that open out to mini gardens, private timber sundecks and verandahs elegantly framing either lush greenery or an expanse of sea. Guests are assured of a superior slumber with goose feather pillows and luxe mattresses paired with 400 thread count Egyptian cotton bed linen, tastefully paired with a full complement of luxurious in-room amenities and bathrooms boasting rain showers and free-standing tubs coupled with an exclusive array of ESPA amenities and toiletries. Guests also get to enjoy complimentary day access to the facilities at Asia’s flagship spa – the world-renowned ESPA.",
      "amenities" => ["Aircon", "Tv", "Coffee machine", "Kettle", "Hair dryer", "Iron", "Tub"],
      "images" =>
   {"rooms" => [{"url" => "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg", "description" => "Double room"}, {"url" => "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg", "description" => "Bathroom"}],
    "amenities" => [{"url" => "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/0.jpg", "description" => "RWS"}, {"url" => "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/6.jpg", "description" => "Sentosa Gateway"}]}
    }
    api2 = ::Api2.from_json(json)
    assert_equal "iJhz", api2.id
    assert_equal 5432, api2.destination
    assert_equal "Beach Villas Singapore", api2.name
    assert_equal 1.264751, api2.latitude
    assert_equal 103.824006, api2.longitude
    assert_equal "8 Sentosa Gateway, Beach Villas, 098269", api2.address
    assert_equal "Located at the western tip of Resorts World Sentosa, guests at the Beach Villas are guaranteed privacy while they enjoy spectacular views of glittering waters. Guests will find themselves in paradise with this series of exquisite tropical sanctuaries, making it the perfect setting for an idyllic retreat. Within each villa, guests will discover living areas and bedrooms that open out to mini gardens, private timber sundecks and verandahs elegantly framing either lush greenery or an expanse of sea. Guests are assured of a superior slumber with goose feather pillows and luxe mattresses paired with 400 thread count Egyptian cotton bed linen, tastefully paired with a full complement of luxurious in-room amenities and bathrooms boasting rain showers and free-standing tubs coupled with an exclusive array of ESPA amenities and toiletries. Guests also get to enjoy complimentary day access to the facilities at Asia’s flagship spa – the world-renowned ESPA.", api2.info
    assert_equal ["Aircon", "Tv", "Coffee machine", "Kettle", "Hair dryer", "Iron", "Tub"], api2.amenities
    assert_equal "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg", api2.images.rooms.first.url
    assert_equal "Double room", api2.images.rooms.first.description
    assert_equal "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg", api2.images.rooms.second.url
    assert_equal "Bathroom", api2.images.rooms.second.description
    assert_equal "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/0.jpg", api2.images.amenities.first.url
    assert_equal "RWS", api2.images.amenities.first.description
    assert_equal "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/6.jpg", api2.images.amenities.second.url
    assert_equal "Sentosa Gateway", api2.images.amenities.second.description
  end
end
