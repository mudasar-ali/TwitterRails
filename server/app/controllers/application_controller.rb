class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

   rescue_from StandardError, with: :internal_server_error
   rescue_from ActiveRecord::RecordNotFound, with: :record_not_found


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:username, :name, :bio, :prof_pic]
    devise_parameter_sanitizer.permit :account_update, keys: [ :bio, :prof_pic, :name, :username]

  end

  def rendering_errors(errors,status)
     render json: {
          success: false,
          errors: errors
        }, status: status
  end

   def routing_error
    render json: {
        error:"Route does not match"
    }, status: :not_found
  end

  def internal_server_error
    render json: { error: 'Internal server error' }, status: :internal_server_error
  end

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end


end
