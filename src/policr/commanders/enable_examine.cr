module Policr
  class EnableExamineCommander < Commander
    def initialize(bot)
      super(bot, "enable_examine")
    end

    def handle(msg)
      role = DB.trust_admin?(msg.chat.id) ? :admin : :creator
      if (user = msg.from) && bot.has_permission?(msg.chat.id, user.id, role)
        text = t "examine.enable"
        if bot.is_admin?(msg.chat.id, bot.self_id.to_i32)
          DB.enable_examine(msg.chat.id)
        else
          text = t "examine.enable_need_permission"
        end
        bot.send_message msg.chat.id, text, reply_to_message_id: msg.message_id, disable_web_page_preview: true, parse_mode: "markdown"
      else
        bot.delete_message(msg.chat.id, msg.message_id)
      end
    end
  end
end
