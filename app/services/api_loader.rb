class ApiLoader
  APIS = [DataLoaders::Api1.new, DataLoaders::Api2.new, DataLoaders::Api3.new]

  # Returns the loaded data from all APIs
  # Format:
  # { "api1" => [Api1Data1, Api1Data2, ...], "api2" => [Api2Data1, Api2Data2, ...], ... }
  def load_all
    APIS.map do |api|
      model_name = api.class.name.split("::").last
      [model_name.downcase, api.load_all]
    end.to_h
  end
end
