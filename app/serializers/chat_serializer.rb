class ChatSerializer
  def initialize(chat)
    @chat = chat
  end
  
  def as_json(*)
    {
      number: @chat.number,
      messages_count: @chat.messages_count,
      created_at: @chat.created_at,
      updated_at: @chat.updated_at,
      application: ApplicationSerializer.new(@chat.application).as_json
    }
  end
end
  