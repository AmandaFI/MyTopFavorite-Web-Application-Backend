module Mutations
    class UnfollowUser < BaseMutation
        description "Unfollows a user."

        argument :id, ID, required: true   

        field :user, Types::UserType, null: false
        field :errors, [String], null: false

        def resolve(id:)
            require_authentication!
            
            user_to_be_unfollowed = User.find(id)

            if current_user.followed_users.delete(user_to_be_unfollowed)
                {user: user_to_be_unfollowed, errors: []}
            else
                {user: nil, errors: user_to_be_unfollowed.errors.full_messages}
            end
        end
    end
end