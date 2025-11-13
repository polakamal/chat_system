class MessageSerializer
  def initialize(message)
    @message = message
  end
  
  def as_json(*)
    {
      body: @message.body,
      created_at: @message.created_at,
      updated_at: @message.updated_at,
      chat: ChatSerializer.new(@message.chat).as_json
    }
  end
end
  