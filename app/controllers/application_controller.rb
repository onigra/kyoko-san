class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :auth_token_check

  def current_user
    return nil unless params[:auth_token]
    User.where(auth_token: params[:auth_token]).first
  end

  private
    def auth_token_check
      render json: {}, status: 404 unless params[:auth_token]
    end
end
