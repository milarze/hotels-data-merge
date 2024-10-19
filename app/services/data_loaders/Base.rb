class DataLoaders::Base
  include HttpRequest

  def load_all
    data = JSON.parse(get(url).body)
    data.each do |item|
      puts item
    end
  end

  def url
    raise "You must implement this method in a child class"
  end
end
