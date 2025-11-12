class ApplicationsController < ActionController::API
  
  def index
    require 'services/applications/index'
    index = ::Services::Applications::Index.new(params)
    render json: index.to_hash, status: :ok
  end

  # GET /applications/:token
  def show
    begin 
      require 'services/applications/show'
      show = ::Services::Applications::Show.new({token: params[:token]})
      render json: show.to_hash, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end

  def create
    begin
      require 'services/applications/create'
      create = ::Services::Applications::Create.new({params: application_params})
      create.process!
      render json: { message: "Application created successfully" }, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def update
    begin 
      require 'services/applications/update'
      update = ::Services::Applications::Update.new({token: params[:token], params: application_params })
      update.process!
      render json: { message: "Application updated successfully" }, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  #------#
   private
  #------#
  def application_params
    params.require(:application).permit(:name)
  end
end
