# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins '*'
#     resource '*', headers: :any, methods: :any
#   end
# end

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # origins 'https://mytopfavoriteinterface.onrender.com'
    origins /\A/\d{,2}|1\d{2}|2[0-4]\d|25[0-5]/\./\d{,2}|1\d{2}|2[0-4]\d|25[0-5]/\./\d{,2}|1\d{2}|2[0-4]\d|25[0-5]/\./\d{,2}|1\d{2}|2[0-4]\d|25[0-5]/\z/
    resource '*', headers: :any, methods: :any, credentials: true
  end
end

# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     # dominio mapeado para 127.0.0.1 no arquivo /etc/hosts
#     origins 'http://mytopfavorite.com:5173'
#     resource '*', headers: :any, methods: :any, credentials: true
#   end
# end


