class Apiloader
  APIS = [Api1, Api2, Api3]

  # Returns the loaded data from all APIs
  # Format:
  # { "api1" => [Api1Data1, Api1Data2, ...], "api2" => [Api2Data1, Api2Data2, ...], ... }
  def self.load_all
    APIS.map do |api|
      [api.class.name.downcase, api.load_all]
    end.to_h
  end
end
