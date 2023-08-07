module Mutations
    class DislikeList < BaseMutation
        description "Dislikes a list."

        argument :id, ID, required: true   

        field :list, Types::ListType, null: false
        field :errors, [String], null: false

        def resolve(id:)
            require_authentication!
            
            list = List.find(id)

            if list.likers.delete(current_user)
                {list: list, errors: []}
            else
                {list: nil, errors: list.errors.full_messages}
            end
        end
    end
end