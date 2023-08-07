module Mutations
    class FollowUser < BaseMutation
        description "Follows a user."

        argument :id, ID, required: true   

        field :user, Types::UserType, null: false
        field :errors, [String], null: false

        def resolve(id:)
            require_authentication!
            
            user_to_be_followed = User.find(id)

            if current_user.followed_users << user_to_be_followed
                {user: user_to_be_followed, errors: []}
            else
                {user: nil, errors: user_to_be_followed.errors.full_messages}
            end
        end
    end
end