# frozen_string_literal: true

def send_payload(payload)
  endpoint = ENV['GATEWAY_URL']
  @logger.info("Sending event to #{endpoint}")
  uri = URI.parse(endpoint)
  http = Net::HTTP.new(uri.host, uri.port)

  request = Net::HTTP::Post.new(uri.request_uri, { 'Content-Type': 'text/json' })
  request.body = payload.to_json
  response = http.request(request)

  @logger.info("request sent, status code is #{response.code}")

  case response
  when Net::HTTPSuccess
    @logger.info('Sucessful')
  when Net::HTTPUnauthorized
    @logger.error("error #{response.message}: username and password set and correct?")
    exit 1
  when Net::HTTPServerError
    @logger.error("error #{response.message}: try again later?")
    exit 2
  else
    @logger.error("error #{response.message}")
    exit 3
  end

  response
end
