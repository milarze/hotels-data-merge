require "net/http"

module HttpRequest
  def get(url)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    request = Net::HTTP::Get.new(uri)
    response = http.request(request)
    if response.is_a?(Net::HTTPSuccess)
      response
    else
      raise "Request failed with status code #{response.code}"
    end
  end
end
