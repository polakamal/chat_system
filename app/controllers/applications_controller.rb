class ApplicationsController < ActionController::API
  include ErrorHandler

  def index
    require 'services/applications/index'
    index = ::Services::Applications::Index.new(params)
    render json: index.to_hash, status: :ok
  end

  # GET /applications/:token
  def show 
    require 'services/applications/show'
    show = ::Services::Applications::Show.new({token: params[:token]})
    render json: show.to_hash, status: :ok
  end

  def create
    require 'services/applications/create'
    create = ::Services::Applications::Create.new({params: application_params})
    create.process!
    render json: { message: "Application created successfully" }, status: :created
  end

  def update
    require 'services/applications/update'
    update = ::Services::Applications::Update.new({token: params[:token], params: application_params })
    update.process!
    render json: { message: "Application updated successfully" }, status: :update
  end

  #------#
   private
  #------#
  def application_params
    params.require(:application).permit(:name)
  end
end
