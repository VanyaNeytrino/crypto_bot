require "http/client"
require "json"

class CryptoApi
  @currency_pair : String
  @crypto_currency : Array(String)

  def initialize(@base_currency : String, @counter_currency : String)
    @currency_pair = "#{@base_currency}-#{@counter_currency}"
    @crypto_currency = ["btc", "eth", "ltc", "doge"]
  end

  def exchange_rates
    response = HTTP::Client.get "https://api.cryptonator.com/api/ticker/#{@currency_pair}"
    result = JSON.parse(response.body)
    puts result
    if @crypto_currency.includes?(result["ticker"]["target"].as_s.downcase)
      result = result["ticker"]["price"].as_s
    else
      result = result["ticker"]["price"].as_s.to_f.round(2)
    end
    return result
  end

end
