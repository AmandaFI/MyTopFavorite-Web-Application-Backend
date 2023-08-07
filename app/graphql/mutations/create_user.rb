module Mutations
    class CreateUser < BaseMutation
        description "Creates a new user."

        # parametros (dto)
        argument :email, String, required: true
        argument :password, String, required: true 
        argument :name, String, required: true
        
        # retornos
        field :user, Types::UserType, null: false
        field :errors, [String], null: false

        def resolve(email:, password:, name:)
            require_authentication!

            user = User.new({email: email, password: password, name: name})

            if user.save
                {user: user, errors: []}
            else
                {user: nil, errors: user.errors.full_messages}
            end
        end
    end
end