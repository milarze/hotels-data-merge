class Api3
  include ActiveModel::Model

  attr_accessor :hotel_id, :destination_id, :hotel_name, :location, :details, :amenities, :images, :booking_conditions

  alias_attribute :id, :hotel_id
  alias_attribute :destination, :destination_id

  def initialize(
    hotel_id:,
    destination_id:,
    hotel_name:,
    location:,
    details:,
    amenities:,
    images:,
    booking_conditions:
  )
    @hotel_id = hotel_id
    @destination_id = destination_id
    @hotel_name = hotel_name
    @location = location
    @details = details
    @amenities = amenities
    @images = images
    @booking_conditions = booking_conditions
  end

  def self.from_json(json)
    new(
      hotel_id: json["hotel_id"],
      destination_id: json["destination_id"],
      hotel_name: json["hotel_name"],
      location: Location.from_json(json["location"]),
      details: json["details"],
      amenities: Amenities.from_json(json["amenities"]),
      images: Images.from_json(json["images"]),
      booking_conditions: json["booking_conditions"]
    )
  end

  class Images
    include ActiveModel::Model

    attr_accessor :rooms, :site

    def initialize(
      rooms:,
      site:
    )
      @rooms = rooms
      @site = site
    end

    def self.from_json(json)
      new(
        rooms: json["rooms"].map { |room| Image.new(link: room["link"], description: room["caption"]) },
        site: json["site"].map { |site| Image.new(link: site["link"], description: site["caption"]) }
      )
    end
  end

  class Location
    include ActiveModel::Model

    attr_accessor :address, :country

    def initialize(
      address:,
      country:
    )
      @address = address
      @country = country
    end

    def self.from_json(json)
      new(
        address: json["address"],
        country: json["country"]
      )
    end
  end

  class Amenities
    include ActiveModel::Model

    attr_accessor :general, :room

    def initialize(
      general:,
      room:
    )
      @general = general
      @room = room
    end

    def self.from_json(json)
      new(
        general: json["general"],
        room: json["room"]
      )
    end
  end
end
