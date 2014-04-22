class SessionsController < ApplicationController  
  def create
    return missing_params unless (params[:email] && params[:password])

    if @user = login(params[:email], params[:password])
      create_auth_token
    else
      user_not_found
    end
  end

  def destroy
    return missing_params unless params[:auth_token]

    if @user = User.find_by(auth_token: params[:auth_token])
      destroy_auth_token
    else
      user_not_found
    end
  end

  private
    def missing_params
      render nothing: true, status: 400
    end

    def user_not_found
      render nothing: true, status: 401
    end

    def create_auth_token
      if @user.generate_token
        render json: @user, status: 201
      else
        render nothing: true, status: 500
      end
    end

    def destroy_auth_token
      if @user.destroy_token
        render nothing: true, status: 204
      else
        render nothing: true, status: 500
      end
    end
end
