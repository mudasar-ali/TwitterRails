class User::ConfirmationsController <  DeviseTokenAuth::TokenValidationsController
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.messages.empty?
        render json: {
          success: "success",
          message:"Email has been confirmed successfully"
        }
      else
        render json: {
          success: false,
          errors: ["Email cannot be verfied. Something is wrong"]
        }, status: 401

      end
  end
end
