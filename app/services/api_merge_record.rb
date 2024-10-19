class ApiMergeRecord
  SKIP_HUMANIZE = %w[WiFi].freeze
  def initialize(api1:, api2:, api3:)
    @api1 = api1
    @api2 = api2
    @api3 = api3
  end

  def merge
    # Merge the data from the three APIs
    Response.new(
      id: @api1&.id || @api2&.id || @api3.id,
      destination_id: @api1&.destination || @api2&.destination || @api3.destination,
      # Get the first one with a name
      name: @api1&.name || @api2&.name || @api3.name,
      location: merge_location,
      description: @api3.details,
      amenities: merge_amenities,
      images: merge_images,
      booking_conditions: @api3.booking_conditions
    )
  end

  private

  def merge_location
    # Merge the location data from the three APIs
    Response::Location.new(
      lat: @api1&.latitude || @api2&.latitude,
      lng: @api1&.longitude || @api2&.longitude,
      # Use address with postal code
      address: @api2&.address || @api3.location.address,
      city: @api1.city,
      # Prioritize fully formed country name instead of country code
      country: @api3&.location&.country || @api1.country
    )
  end

  def merge_amenities
    # Merge the amenities data from the three APIs
    general = merge_string_array(@api3.amenities&.general, @api1&.facilities)
    room = merge_string_array(Array.wrap(@api2&.amenities), Array.wrap(@api3&.amenities&.room))
    Response::Amenities.new(
      general: general,
      room: room
    )
  end

  def merge_images
    Response::Images.new(
      rooms: merge_image_array(@api3&.images&.rooms, @api2&.images&.rooms),
      site: merge_image_array(@api3&.images&.site),
      amenities: merge_image_array(@api2&.images&.amenities)
    )
  end

  def merge_string_array(*arrays)
    # Merge string arrays and remove any elements that are substrings of other elements
    uniqued_values = arrays.flatten.map { |e| sanitize_string(e) }.compact.uniq
    uniqued_values.reject do |e|
      uniqued_values.any? { |other| e != other && other.include?(e) }
    end
  end

  def sanitize_string(string)
    cleaned = string.strip
    cleaned = cleaned.underscore.humanize unless SKIP_HUMANIZE.include?(cleaned)
    cleaned.downcase
  end

  def merge_image_array(*arrays)
    tuples = arrays.flatten.map { |e| e.nil? ? nil : [e.link, e.description] }.compact
    hash = tuples.to_h
    hash.map do |k, v|
      Response::Image.new(
        link: k,
        description: v
      )
    end
  end
end
