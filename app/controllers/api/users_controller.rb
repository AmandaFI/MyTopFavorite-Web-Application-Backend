class Api::UsersController < Api::ApiController

  skip_before_action :authenticate_user, only: [ :create ]
  before_action :find_user_by_id, only: [ :destroy, :show ]

  def index
    @users = User.all
    render json: @users
  end

  def show
    if @user
      render json: @user
    else 
      render head :not_found
    end
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
        render json: {errors: current_user.errors.full_messages}, status: :unprocessable_entity
      end
  end

  def destroy
    @user.destroy
    render json: :no_content
  end

  def follow
    user_to_be_followed = User.find(params[:user_id])

    if current_user.followed_users << user_to_be_followed
      render json: user_to_be_followed, status: :created
    else
      render json: user_to_be_followed.errors.full_messages, status: :unprocessable_entity
    end 
  end

  def unfollow
    user_to_be_unfollowed = User.find(params[:user_id])
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

    lists = current_user.followed_users.flat_map do |user| 
      user.lists.published.order(created_at: :desc).limit(per_page).offset(per_page * (page - 1))
    end
    render json: lists, each_serializer: CompleteListSerializer
    # lists = current_user.followed_users.map(&:lists).flatten
    # lists = current_user.followed_users.flat_map(&:lists)
  end

  def find_users
    render json: User.where('name LIKE ?', "#{params[:name]}%").all#, each_serializer simplify
    # render json: User.where('name LIKE ?', "#{search_users_params[:name]}%").all
  end

  def check_following
    followed_user = current_user.followed_users.find(params[:id])
    if followed_user
      render json: followed_user
    else 
      render head :not_found
    end
  end


  private
    def find_user_by_id
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # On this case, create_params and update_params are the same
    def user_params
      params.permit(:email, :password, :name)
    end

    # def followed_params
    #   params.permit(:user_id)
    # end

    def search_users_params
      params.permit(:name)
    end
end