class SessionsController < ApplicationController  
  def create
    return missing_params unless (params[:email] && params[:password])

    if @user = login(params[:email], params[:password])
      @user.generate_token
      render json: @user, status: 201
    else
      return user_not_found
    end
  end

  def destroy
    return missing_params unless params[:auth_token]

    if @user = User.find_by(auth_token: params[:auth_token])
      @user.destroy_token
      render nothing: true, status: 204
    else
      return user_not_found
    end
  end

  private
    def missing_params
      render nothing: true, status: 400
    end

    def user_not_found
      render nothing: true, status: 401
    end
end
