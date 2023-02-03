class ApplicationController < ActionController::API
  include JwtToken

  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def pundit_user
    @current_user
  end

  def authenticate_user
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    begin
      @decoded = jwt_decode header
      @current_user = User.find @decoded[:user_id]
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  private

  def user_not_authorized
    render json: { error: "You are not authorized to perform this action" },
           status: :forbidden
  end
end
