class Api::SessionsController < Api::ApiController

  skip_before_action :authenticate_user, only: :create

  # login
  def create
    user = User.authenticate(params[:email], params[:password])

    if user
      session[:logged_user_id] = user.id
      render json: user, status: :created
      # mandou um cookie
    else
      # session[:logged_user_id] = nil
      session.delete :logged_user_id

      head :not_found
    end
  end

  # logout
  def destroy
    session.delete :logged_user_id

    head :no_content
  end

  private
    def create_params
      params.permit(:email, :password)
    end

end