require 'telegram/bot'
TELEGRAM_TOKEN = ENV["TELEGRAM_TOKEN"]

Telegram::Bot::Client.run(TELEGRAM_TOKEN) do |bot|

  bot.listen do |msg|

    case msg
    when "/start"
      bot.api.sendMessage(chat_id: chat_id, text: "Hello, #{username}")
    when "/code"
    when "/reset"
    end

  end

end