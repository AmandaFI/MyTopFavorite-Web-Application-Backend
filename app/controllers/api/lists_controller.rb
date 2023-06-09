class Api::ListsController < Api::ApiController
  before_action :find_list, only: [ :show, :update, :destroy, :like, :dislike ]
  before_action :find_user_by_id, only: [ :published_lists  ]


  def index
      render json: current_user.lists.order(updated_at: :desc)
      #.limit(per_page).offset(per_page * (page - 1))
  end

  def show
    render json: @list, serializer: CompleteListSerializer, current_user: current_user
  end

  def create
    # list = current_user.lists << List.new(create_params)
    current_user.lists << List.new(create_params)
    list = current_user.lists.last

      if list.save
        render json: list, status: :created
      else
        render json: list.errors.full_messages, status: :unprocessable_entity
      end
  end

  def update
      if @list.update(update_params)
        render json: @list, status: :ok
      else
        render json: {errors: @list.errorsfull_messages, status: :unprocessable_entity}
      end
  end

  def destroy
    # @list.items.each { |i| i.destroy } # feito no on_delete cascade
    @list.destroy
    render json: :no_content
  end

  
  def like

    if @list.likers << current_user
      render json: current_user, status: :created, serializer: BasicUserSerializer
    else
      render json: current_user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def dislike

    if @list.likers.delete(current_user)
      render json: :no_content
    else
      render json: current_user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def draft_lists
    render json: current_user.lists.draft.order(updated_at: :desc)
  end

  def published_lists
    if @user
      if params[:page]
        render json: @user.lists.published.order(updated_at: :desc).limit(per_page).offset(per_page * (page - 1)), each_serializer: CompleteListSerializer, current_user: current_user
      else
        render json: @user.lists.published.order(updated_at: :desc)
      end
    else
      render head :not_found
    end
  end

  private
    def find_list
      @list = List.find(params[:id])
    end

    def find_user_by_id
      @user = User.find(params[:id])
    end

    def create_params
      params.permit(:title, :category_id, :draft)
    end

    def update_params
      params.permit(:title, :draft)
    end
  
end