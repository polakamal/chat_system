module Counters
  class ChatCounter
    def self.next(application_id)
        $redis.incr("application:#{application_id}:chat_number")
    end
  end
end
  