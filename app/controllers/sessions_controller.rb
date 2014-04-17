class SessionsController < ApplicationController  
  def create
    unless (params[:email] && params[:password])
      return missing_params
    end

    if @user = login(params[:email], params[:password])
      @user.generate_token
      render json: @user
    else
      user_not_found
    end
  end

  def destroy
    return missing_params unless params[:auth_token]
    @user = User.find_by auth_token: params[:auth_token]
    return user_not_found unless @operator
    @user.destroy_token
    render nothing: true, status: 200
  end

  private
    def missing_params
      render nothing: true, status: 400
    end

    def user_not_found
      render nothing: true, status: 400
    end
end
