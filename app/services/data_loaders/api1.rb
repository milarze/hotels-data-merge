class DataLoaders::Api1 < DataLoaders::Base
  URL = "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme"

  def url
    URL
  end

  def load_all
    load_all_json.map { |data| Api1.from_json(data) }
  end
end
