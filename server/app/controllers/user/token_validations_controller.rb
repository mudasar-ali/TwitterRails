class User::TokenValidationsController < DeviseTokenAuth::TokenValidationsController
  skip_before_action :authenticate_user!
  def validate_token
    super
  end
end
