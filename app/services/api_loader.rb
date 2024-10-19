class ApiLoader
  APIS = [DataLoaders::Api1.new, DataLoaders::Api2.new, DataLoaders::Api3.new]

  # Returns the loaded data from all APIs
  # Format:
  # { "api1" => [Api1Data1, Api1Data2, ...], "api2" => [Api2Data1, Api2Data2, ...], ... }
  def load_all
    data = []
    threads = APIS.map do |api|
      Thread.new do
        model_name = api.class.name.split("::").last
        data << [model_name.downcase, api.load_all]
      end
    end
    threads.each(&:join)
    data.to_h
  end
end
