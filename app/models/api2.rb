class Api2
  include ActiveModel::Model

  attr_accessor :id, :destination, :name, :latitude, :longitude, :address, :info, :amenities, :images

  def initialize(
    id:,
    destination:,
    name:,
    latitude:,
    longitude:,
    address:,
    info:,
    amenities:,
    images:
  )
    @id = id
    @destination = destination
    @name = name
    @latitude = latitude
    @longitude = longitude
    @address = address
    @info = info
    @amenities = amenities
    @images = images
  end

  def self.from_json(json)
    new(
      id: json["id"],
      destination: json["destination"],
      name: json["name"],
      latitude: json["lat"],
      longitude: json["lng"],
      address: json["address"],
      info: json["info"],
      amenities: json["amenities"],
      images: Images.from_json(json["images"])
    )
  end

  class Images
    include ActiveModel::Model

    attr_accessor :rooms, :amenities

    def initialize(
      rooms:,
      amenities:
    )
      @rooms = rooms
      @amenities = amenities
    end

    def self.from_json(json)
      new(
        rooms: json["rooms"].map { |room| Image.new(link: room["url"], description: room["description"]) },
        amenities: json["amenities"].map { |amenity| Image.new(link: amenity["url"], description: amenity["description"]) }
      )
    end
  end
end
