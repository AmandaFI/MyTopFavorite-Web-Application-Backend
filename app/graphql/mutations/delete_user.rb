module Mutations
    class DeleteUser < BaseMutation
        description "Deletes a user."

        argument :id, ID, required: true   

        field :user, Types::UserType, null: false
        field :errors, [String], null: false

        def resolve(id:)
            require_authentication!
            
            user = User.find(id)

            if user.destroy
                {user: user, errors: []}
            else
                {user: nil, errors: user.errors.full_messages}
            end
        end
    end
end