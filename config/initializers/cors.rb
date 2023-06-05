# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins '*'
#     resource '*', headers: :any, methods: :any
#   end
# end

# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins 'http://localhost:5173'
#     resource '*', headers: :any, methods: :any, credentials: true
#   end
# end

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # dominio mapeado para 127.0.0.1 no arquivo /etc/hosts
    origins 'http://mytopfavorite.com:5173'
    resource '*', headers: :any, methods: :any, credentials: true
  end
end
