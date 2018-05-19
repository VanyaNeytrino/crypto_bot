require "./crypto_bot/*"
require "./crypto_api"
require "./counter"
require "telegram_bot"
require "json"

# TODO: Write documentation for `CryptoBot`
module CryptoBot
  class MyBot < TelegramBot::Bot
    include TelegramBot::CmdHandler
    @text : String
    @text = "Привет, я бот по крипте"
    TOKEN = "bot_token"

    def initialize
      super("MyBot", TOKEN)

      cmd "start" do |msg|
        user = msg.from
        if user
         reply msg, "Hello, #{user.first_name}"
         reply msg, "#{@text}"
        end
      end

      cmd "get_course" do |msg, params|
        course = CryptoApi.new(params[0], params[1])
        result = course.exchange_rates
        if result
          reply msg, "1 #{params[0]} = #{result.to_s} #{params[1]}"
        end
      end
      cmd "count" do |msg, params|
        calculete = Counter.new(params[0].sub(',', "."), params[1], params[2])
        reply msg, "#{calculete.count} #{params[2]}"
      end
    end
  end
end
my_bot = CryptoBot::MyBot.new
my_bot.polling
