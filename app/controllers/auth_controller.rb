class AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create # POST /login
    @user = User.find_by(email: login_params[:email])
    # @user.authenticate('password')
    byebug
    if @user && @user.authenticate(login_params[:password])
      @token = encode_token({ password: @user.password })
      render json: { user: @user, jwt: @token }, status: :accepted
    else
      render json: { errors: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private
  def login_params
    params.require(:user).permit(:email, :password)
  end
end
