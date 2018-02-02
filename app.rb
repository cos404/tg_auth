require 'telegram/bot'
require 'mongoid'
require_relative 'models/user'

TELEGRAM_TOKEN = ENV["TELEGRAM_TOKEN"]
Mongoid.load!('config/mongoid.yml', :development)

Telegram::Bot::Client.run(TELEGRAM_TOKEN) do |bot|
  puts "Bot run"

  bot.listen do |message|
    username = message.from.username
    chat_id = message.chat.id
    msg = message.text
    user_id = message.from.id

    case msg
    when "/start"
      first_name = message.from.first_name
      last_name = message.from.last_name
      language_code = message.from.language_code

      User.find_or_create_by(
        username: username,
        first_name: first_name,
        last_name: last_name,
        _id: user_id,
        language_code: language_code)

      bot.api.sendMessage(
        chat_id: chat_id,
        text: "You have signed up successfully. To get the code, enter: /code."
      )
    when "/code"
      code = 4.times.map{rand(10)}.join
      token = username.crypt(code)

      User.where(_id: user_id).update(username: username, token: token)

      bot.api.sendMessage(
        chat_id: chat_id,
        text: "Your login: #{username}.\nYour code: #{code}"
      )
    end

  end
end