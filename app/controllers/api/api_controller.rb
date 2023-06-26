class Api::ApiController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :authenticate_user
  before_action :snake_case_params

  SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

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

    # # Versão sem usar o metodo do rails authenticate_with_http_token que já pega o token ignorando a palavra Bearer
    # def authenticate_user

    #   header = request.headers['Authorization']
    #   token = header.split(' ').last if header   # a primeira palavra será Bearer seguida por um espaço e em seguida o token

    #   if token
    #       @current_user ||= begin
    #       user_id = decode_jwt(token)[0]["user_id"]
    #       User.find(user_id) if user_id
    #     end 
    #   else
    #     head :unauthorized # 401 
    #   end  
    # end

    def authenticate_user

        decoded_token ||=
          begin
            authenticate_with_http_token do |token, _|
              HashWithIndifferentAccess.new(decode_jwt(token)[0])
            end
          rescue JWT::ExpiredSignature, JWT::DecodeError  
          end

        if decoded_token
          @current_user ||= User.find_by id: decoded_token[:user_id]
        else
          head :unauthorized # 401 
        end
    end

    def logged_in?
      !!@current_user  
      # primiero ! transforma @current_user em boolean e o nega (será false), 
      # segundo ! nega o boolean da transformação anterior (será true)
    end

    def encode_jwt(payload)
      JWT.encode payload, SECRET_KEY, "HS256"
    end

    def decode_jwt(token)
      JWT.decode token, SECRET_KEY, true, algorithm: "HS256"
    end

end
