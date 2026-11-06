# Track a Product with a Target Price – Ruby example (stdlib only)
# Usage: ASIN_API_KEY=your-key ruby create_alert.rb
require "json"
require "net/http"
require "uri"

def call(method, url, body = nil)
  uri = URI(url)
  klass = { "GET" => Net::HTTP::Get, "POST" => Net::HTTP::Post, "PUT" => Net::HTTP::Put, "PATCH" => Net::HTTP::Patch, "DELETE" => Net::HTTP::Delete }[method]
  req = klass.new(uri)
  req["Authorization"] = "Bearer #{ENV.fetch("ASIN_API_KEY")}"
  if body
    req["Content-Type"] = "application/json"
    req.body = body
  end
  res = Net::HTTP.start(uri.host, uri.port, use_ssl: true, read_timeout: 120) { |http| http.request(req) }
  abort "HTTP #{res.code}: #{res.body}" unless res.is_a?(Net::HTTPSuccess)
  res.body
end

response = call("POST", "https://www.asin.dev/api/v1/products", '{"product": "B09DFCB66S", "marketplace": "com", "target_price": 70}')

puts JSON.pretty_generate(JSON.parse(response))
