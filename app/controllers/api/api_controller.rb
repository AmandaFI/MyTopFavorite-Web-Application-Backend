class Api::ApiController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :authenticate_user
  before_action :snake_case_params

  DEFAULT_PER_PAGE = 3
  MAX_PER_PAGE = 100

  protected
    # get de current_user
    attr_reader :current_user

    # memoization
    def page 
      @page ||= (params[:page] || 1).to_i
    end

    def per_page
      @per_page ||= [ (params[:per_page] || DEFAULT_PER_PAGE).to_i, MAX_PER_PAGE].min
    # per_page = [per_page, MAX_PER_PAGE].min
    end


    def snake_case_params
      request.parameters.deep_transform_keys! &:underscore
    end

    def authenticate_user
      if session[:logged_user_id]
        # com o find, se não encontrar da o erro 404
        # com o find_by nãoda erro e retorna nil
        @current_user = User.find(session[:logged_user_id])
      else
        head :unauthorized  # 401 
      end
    end

    def logged_in?
      !!@current_user  
      # primiero ! transforma @current_user em boolean e o nega (será false), 
      # segundo ! nega o boolean da transformação anterior (será true)
    end

end
