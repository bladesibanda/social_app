class AuthenticationController < ApplicationController
  def login
    @user = User.find_by_email params[:email]
    if @user&.authenticate params[:password]
      payload = { user_id: @user.id }
      token = jwt_encode payload, exp: 2.days.from_now
      render json: { token: token, name: @user.name }
    else
      render json: { error: "invalid email/password" }, status: :unauthorized
    end
  end
end
