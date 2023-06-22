class Api::ApiController < ApplicationController

  before_action :set_headers

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


  private

  def set_headers
    if request.headers["HTTP_ORIGIN"]
    # better way check origin
    # if request.headers["HTTP_ORIGIN"] && /^https?:\/\/(.*)\.some\.site\.com$/i.match(request.headers["HTTP_ORIGIN"])
      headers['Access-Control-Allow-Origin'] = request.headers["HTTP_ORIGIN"]
      headers['Access-Control-Expose-Headers'] = 'ETag'
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
      headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Auth-User-Token'
      headers['Access-Control-Max-Age'] = '86400'
      headers['Access-Control-Allow-Credentials'] = 'true'
    end
  end

end
