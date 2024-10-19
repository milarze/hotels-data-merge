class Api1
  include ActiveModel::Model

  attr_accessor :id, :destination, :name, :latitude, :longitude, :address, :city, :country, :postal_code, :description, :facilities

  def initialize(
    id:,
    destination:,
    name:,
    latitude:,
    longitude:,
    address:,
    city:,
    country:,
    postal_code:,
    description:,
    facilities:
  )
    @id = id
    @destination = destination
    @name = name
    @latitude = latitude
    @longitude = longitude
    @address = address
    @city = city
    @country = country
    @postal_code = postal_code
    @description = description
    @facilities = facilities
  end

  def self.from_json(json)
    new(
      id: json["Id"],
      destination: json["DestinationId"],
      name: json["Name"],
      latitude: json["Latitude"],
      longitude: json["Longitude"],
      address: json["Address"],
      city: json["City"],
      country: json["Country"],
      postal_code: json["PostalCode"],
      description: json["Description"],
      facilities: json["Facilities"]
    )
  end
end
