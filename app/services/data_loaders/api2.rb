class DataLoaders::Api2 < DataLoaders::Base
  URL = "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia"

  def url
    URL
  end

  def load_all
    load_all_json.map { |data| Api2.from_json(data) }
  end
end
