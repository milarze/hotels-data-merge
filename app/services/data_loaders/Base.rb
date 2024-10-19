class DataLoaders::Base
  include HttpRequest

  def load_all
    JSON.parse(get(url).body)
  end

  def url
    raise "You must implement this method in a child class"
  end
end
