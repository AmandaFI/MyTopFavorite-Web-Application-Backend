class ApplicationController < ActionController::Base
  HMAC_SECRET = "secretword"

	def login(user)
		token = encode_jwt(user_id: user.id)

		headers["Authorization"] = "Bearer #{token}"
	end
	
	def logged_in?
		!!current_user
	end
    
	def current_user
		@current_user ||=
			begin
				authenticate_with_http_token do |token, _|
					jwt = decode_jwt(token)
					payload = HashWithIndifferentAccess.new(jwt[0])

					User.find_by id: payload[:user_id]
				end
			rescue JWT::ExpiredSignature, JWT::DecodeError
		end
	end

	private

	def encode_jwt(payload)
		JWT.encode payload, HMAC_SECRET, "HS256"
	end
	
	def decode_jwt(token)
		JWT.decode token, HMAC_SECRET, true, algorithm: "HS256"
	end
end
