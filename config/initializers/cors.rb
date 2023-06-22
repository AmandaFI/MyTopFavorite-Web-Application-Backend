# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins '*'
#     resource '*', headers: :any, methods: :any
#   end
# end

# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins 'https://mytopfavoriteinterface.onrender.com'
#     resource '*', headers: :any, methods: :any, credentials: true
#   end
# end

# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     # dominio mapeado para 127.0.0.1 no arquivo /etc/hosts
#     origins 'http://mytopfavorite.com:5173'
#     resource '*', headers: :any, methods: :any, credentials: true
#   end
# end

before_filter :set_headers

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
