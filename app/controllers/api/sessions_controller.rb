class Api::SessionsController < Api::ApiController

  skip_before_action :authenticate_user, only: :create

  # login
  def create
    user = User.authenticate(params[:email], params[:password])

    if user
      token = encode_jwt(user_id: user.id)
      headers["Authorization"] = "Bearer #{token}"

      render json: user, status: :created
    else
      headers.delete_if { |key| key == "Authorization" }
      head :not_found
    end
  end

  # logout - esse endpoint não é necessário pois basta deletar o token do lado cliente
  # servidor é stateless, nem sabe da existência desse token
  def destroy
    headers.delete_if { |key| key == "Authorization" }

    head :no_content
  end

  def status
    render json: current_user
  end

end