class ChatsController < ActionController::API
  include ErrorHandler
  def index
    require 'services/chats/index'
    index = ::Services::Chats::Index.new(params)
    render json: index.to_hash, status: :ok
  end
  
  def show
    require 'services/chats/show'
    show = ::Services::Chats::Show.new({application_token: params[:application_token], number: params[:number]})
    render json: show.to_hash, status: :ok
  end
  
  def create
    require 'services/chats/create'
    create = ::Services::Chats::Create.new(application_token: params[:application_token])
    create.process!
    number = create.number
    render json: { number: number}, status: :created
  end

end
  