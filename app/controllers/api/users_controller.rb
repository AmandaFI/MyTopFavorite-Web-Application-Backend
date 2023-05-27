class Api::UsersController < Api::ApiController

  before_action :find_user_by_id, only: [ :destroy]
  # before_action :find_user_by_email, only: [:create]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: current_user
  end

  def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: {errors: @user.errors.full_messages, status: :unprocessable_entity}
      end
  end

  def update
      if current_user.update(user_params)
        render json: current_user, status: :ok
      else
        render json: {errors: current_user.errors.full_messages, status: :unprocessable_entity}
      end
  end

  def destroy
    #ARRUMAR DELETAR USER
    # já feito no on_delete cascade
    # @user.lists.each do |l|
    #   l.items.each { |i| i.destroy }
    #   l.destroy
    # end
    @user.destroy
    render json: :no_content
  end

  def follow
    user_to_be_followed = User.find(followed_params[:user_id])

    if current_user.followed_users << user_to_be_followed
      render json: user_to_be_followed, status: :created
    else
      render json: user_to_be_followed.errors.full_messages, status: :unprocessable_entity
    end 
  end

  def unfollow
    user_to_be_unfollowed = User.find(followed_params[:user_id])
    if current_user.followed_users.delete(user_to_be_unfollowed)
      head :no_content
    else
      render json: user_to_be_followed.errors.full_messages, status: :unprocessable_entity
    end 
  end

  def followed_users
    render json: current_user.followed_users
  end

  def followers
    render json: current_user.followers
  end

  def followed_users_lists
    render json: current_user.followed_users.flat_map do |user| 
      user.lists.order(created_at: :desc).limit(3)
    end
    # lists = current_user.followed_users.map(&:lists).flatten
    # lists = current_user.followed_users.flat_map(&:lists)
    
  end

  private
    def find_user_by_id
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # On this case, create_params and update_params are the same
    def user_params
      params.permit(:email, :encrypted_password, :name)
    end

    def followed_params
      params.permit(:user_id)
    end
end