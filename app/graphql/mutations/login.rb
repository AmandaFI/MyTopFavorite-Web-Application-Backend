module Mutations
    class Login < BaseMutation
        description "Logs the user in."

        # parametros (dto)
        argument :email, String, required: true #, validates: { format: { with: URI::MailTo::EMAIL_REGEXP } }  
        argument :password, String, required: true

        # coisas retornadas
        field :user, Types::UserType, null: true
        field :errors, [String], null: false

        # função chamada com os parametros recebidos e que retornará os fields definidos
        def resolve(email:, password:)
            user = User.authenticate_user(email, password)

            if user
                login user     # tem acesso a função login por herdar de GraphqlCommonMethods
                # context[login].call(user)  # também daria certo, sem necessidade da classe intermediária
                {user: user, errors: []}
            else
                {user: nil, errors: ['Invalid credentials']}
            end
        end
    end
end