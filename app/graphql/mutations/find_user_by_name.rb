module Mutations
    class FindUserByName < BaseMutation
        description "Finds user/s by name."

        argument :name, String, required: true

        field :users, [Types::UserType], null: true  
        field :errors, [String], null: false

        def resolve(name:)
            require_authentication!
            
            users = User.where('name LIKE ?', "#{name}%").all
            if users
                {users: users, errors: []}
            else
                {users: nil, errors: users.errors.full_messages}
            end
        end
    end
end