class DataLoaders::Base
  include HttpRequest

  def load_all_json
    JSON.parse(get(url).body)
  end

  def url
    raise "You must implement this method in a child class"
  end

  def load_all
    raise "You must implement this method in a child class"
  end
end
