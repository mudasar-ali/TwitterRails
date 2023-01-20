class User::ConfirmationsController <  DeviseTokenAuth::TokenValidationsController
  skip_before_action :authenticate_user!
  def show
    resource = resource_class.confirm_by_token(params[:confirmation_token])
    if resource.errors.messages.empty?
        render json: {
          message:"Email has been confirmed successfully"
        }, status: :ok
    end
  rendering_errors("Email can not be verified",resource.errors.full_messages, :unprocessable_entity)
  end
end
