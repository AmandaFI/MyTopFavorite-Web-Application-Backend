class Api::ListsController < Api::ApiController
  before_action :find_list, only: [ :show, :update, :destroy, :like, :dislike ]


  def index
    render json: current_user.lists.order(updated_at: :desc)
    #.limit(per_page).offset(per_page * (page - 1))
  end

  def show
    render json: @list, serializer: CompleteListSerializer
  end

  def create
    # list = current_user.lists << List.new(list_params)
    current_user.lists << List.new(list_params)
    list = current_user.lists.last

      if list.save
        render json: list, status: :created
      else
        render json: list.errors.full_messages, status: :unprocessable_entity
      end
  end

  def update
      if @list.update(list_params)
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
      render json: current_user, status: :created
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
    render json: current_user.lists.draft
  end

  def published_lists
    render json: current_user.lists.published
    #.limit(per_page).offset(per_page * (page - 1))
  end

  private
    def find_list
      @list = List.find(params[:id])
    end

    def list_params
      params.permit(:title, :category_id, :draft)
    end
  
end