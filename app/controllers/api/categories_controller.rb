class Api::CategoriesController < Api::ApiController
  before_action :find_category, only: [:update, :destroy, :show]

  def index
    render json: Category.all
  end

  def show
    render json: @category
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created 
    else
      render json: {errors: @category.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    render json: :no_content
  end

  def update
    if @category.update(category_params)
      render json: @category, status: :ok
    else
      render json: {errors: @category.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

    def find_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.permit(:name)
    end

end
