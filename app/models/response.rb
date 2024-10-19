class Response
  include ActiveModel::Model

  attr_accessor :id, :destination_id, :name, :location, :description, :amenities, :images, :booking_conditions

  validate :location, -> { is_a?(Location) }
  validate :images, -> { is_a?(Images) }
  validate :booking_conditions, -> { is_a?(Array) }
  validate :id, -> { is_a?(String) }
  validate :destination_id, -> { is_a?(Integer) }
  validate :name, -> { is_a?(String) }
  validate :description, -> { is_a?(String) }
  validate :amenities, -> { is_a?(Amenities) }

  def initialize(
    id:,
    destination_id:,
    name:,
    location:,
    description:,
    amenities:,
    images:,
    booking_conditions:
  )
    @id = id
    @destination_id = destination_id
    @name = name
    @location = location
    @description = description
    @amenities = amenities
    @images = images
    @booking_conditions = booking_conditions
  end

  def self.from_apis(api1:, api2:, api3:)
    ApiMerge.new(api1: api1, api2: api2, api3: api3).merge
  end

  class Location
    include ActiveModel::Model

    attr_accessor :lat, :lng, :address, :city, :country

    validate :lat, -> { is_a?(Float) }
    validate :lng, -> { is_a?(Float) }
    validate :address, -> { is_a?(String) }
    validate :city, -> { is_a?(String) }
    validate :country, -> { is_a?(String) }

    def initialize(
      lat:,
      lng:,
      address:,
      city:,
      country:
    )
      @lat = lat
      @lng = lng
      @address = address
      @city = city
      @country = country
    end
  end

  class Amenities
    include ActiveModel::Model

    attr_accessor :general, :room

    validate :general, -> { is_a?(Array) }
    validate :room, -> { is_a?(Array) }

    def initialize(
      general:,
      room:
    )
      @general = general
      @room = room
    end
  end

  class Images
    include ActiveModel::Model

    attr_accessor :rooms, :site, :amenities

    validate :rooms, -> { is_a?(Array) }
    validate :site, -> { is_a?(Array) }
    validate :amenities, -> { is_a?(Array) }

    def initialize(
      rooms:,
      site:,
      amenities:
    )
      @rooms = rooms
      @site = site
      @amenities = amenities
    end
  end

  class Image
    include ActiveModel::Model

    attr_accessor :link, :description

    validate :link, -> { is_a?(String) }
    validate :description, -> { is_a?(String) }

    def initialize(
      link:,
      description:
    )
      @link = link
      @description = description
    end
  end
end
