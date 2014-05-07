class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers
  rescue_from ActionController::UnpermittedParameters, with: :bad_request
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def current_user
    User.find_by(auth_token: params[:auth_token])
  end

  # http://blog.rudylee.com/2013/10/29/rails-4-cors/
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = '*'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = '*'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
    headers['Access-Control-Max-Age'] = '1728000'
  end

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
