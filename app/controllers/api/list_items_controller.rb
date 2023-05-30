class   Api::ListItemsController < Api::ApiController
  before_action :find_list_item, only: [ :show, :update, :destroy ]
  before_action :find_list, only: [ :index, :create ]

  def index
    render json: @list.items
  end

  def show
    render json: @list_item
  end

  def create
    @list.items << ListItem.new(create_params.except(:list_id))
    list_item = @list.items.last

    if list_item.save
      render json: list_item, status: :created
    else
      render json: list_item.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    p params[:metadata]
    if @list_item.update(update_params)
      render json: @list_item, status: :ok
    else
      render json: { errors: @list_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @list_item.destroy
    render json: :no_content
  end

  private
    def find_list_item
      @list_item = ListItem.find(params[:id])
    end

    def create_params
      params.permit(:external_api_identifier, :metadata, :rank, :title, :user_comment, :list_id)
    end

    def update_params
      params.permit(:external_api_identifier, :rank, :title, :user_comment)
    end

    def find_list 
      @list = List.find(params[:list_id])
    end
end