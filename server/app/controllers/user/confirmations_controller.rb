class User::ConfirmationsController <  DeviseTokenAuth::TokenValidationsController
  def show
    resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.messages.empty?
        render json: {
          success: "success",
          message:"Email has been confirmed successfully"
        }, status: :ok
      else
       rendering_errors(resource.errors.full_messages, :unprocessable_entity)
      end
  end
end
