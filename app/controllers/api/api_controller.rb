class Api::ApiController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :authenticate_user

  private

    def authenticate_user
      if session[:logged_user_id]
        # se não encontrar current_user será nil
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

    attr_reader :current_user
end
