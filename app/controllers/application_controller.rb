class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  private
    def auth_token_check
      render json: {}, status: 404 unless params[:auth_token]
    end
end
