class ApplicationSerializer
    def initialize(application)
      @application = application
    end
  
  def as_json(*)
    {
      token: @application.token,
      name: @application.name,
      chats_count: @application.chats_count,
      created_at: @application.created_at,
      updated_at: @application.updated_at
    }
  end
end
  