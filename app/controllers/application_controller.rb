class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  rescue_from ActionController::UnpermittedParameters, with: :bad_request
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private
    def auth_token_check
      render nothing: true, status: 404 unless params[:auth_token]
    end

    def bad_request(exception = nil)
      logger.info exception.message if exception
      render nothing: true, status: 400
    end

    def record_not_found(exception = nil)
      logger.info exception.message if exception
      render nothing: true, status: 404
    end

end
