# app/controllers/concerns/error_handler.rb
module ErrorHandler
  extend ActiveSupport::Concern
  
  included do
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotUnique, with: :render_conflict
    rescue_from ActionController::ParameterMissing, with: :render_bad_request
  
    # Optional: catch-all for unexpected errors (comment out in production if you prefer)
    # rescue_from StandardError, with: :render_internal_server_error
  end
  #------#
  private
  #------#
  def render_not_found(exception)
    render json: { error: 'Resource not found' }, status: :not_found
  end
  
  def render_unprocessable_entity(exception)
    render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
  
  def render_conflict(exception)
    render json: { error: 'Conflict: duplicate record' }, status: :conflict
  end
  
  def render_bad_request(exception)
    render json: { error: exception.message }, status: :bad_request
  end
  
  def render_internal_server_error(exception)
    # Log it for debugging, but return a clean response
    Rails.logger.error("[500] #{exception.class}: #{exception.message}")
    Rails.logger.error(exception.backtrace.join("\n")) if Rails.env.development?
    render json: { error: 'Internal server error' }, status: :internal_server_error
  end
end
  