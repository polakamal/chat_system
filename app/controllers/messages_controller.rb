class MessagesController < ActionController::API
  include ErrorHandler
  
  def index
    require 'services/messages/index'
    index = ::Services::Messages::Index.new(params)
    render json: index.to_hash, status: :ok
  end
    
  def show
    require 'services/messages/show'
    show = ::Services::Messages::Show.new({application_token: params[:application_token],
       chat_number: params[:chat_number], message_number: params[:number]})
    render json: show.to_hash, status: :ok
  end
    
  def create
    require 'services/messages/create'
    create = ::Services::Messages::Create.new({application_token: params[:application_token], 
    chat_number: params[:chat_number], params: message_params })
    create.process!
    number = create.number
    render json: { number: number}, status: :created
  end
  
  #------#
   private
  #------#

  def message_params
    params.require(:message).permit(:body)
  end

end
  