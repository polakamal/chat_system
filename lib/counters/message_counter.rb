module Counters
  class MessageCounter
    def self.next(chat_id)
      $redis.incr("chat:#{chat_id}:message_number")
    end
  end
end