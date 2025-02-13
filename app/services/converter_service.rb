require 'net/http'
require 'uri'

class ConverterService
  def initialize(nfe_key)
    @nfe_key = nfe_key
  end

  def execute
    meudanfe_request
  end

  def meudanfe_request
    uri = URI.parse("https://ws.meudanfe.com/api/v1/get/nfe/xml/#{@nfe_key}")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "text/plain;charset=UTF-8"
    request["Origin"] = "https://www.meudanfe.com.br"
    request["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
    request.body = "{}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)

    end

    response.body
  end
end