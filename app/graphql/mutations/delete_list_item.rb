module Mutations
    class DeleteListItem < BaseMutation
        description "Deletes a list item."

        argument :id, ID, required: true   

        field :listItem, Types::ListItemType, null: false
        field :errors, [String], null: false

        def resolve(id:)
            require_authentication!
            
            listItem = ListItem.find(id)

            if listItem.destroy
                {listItem: listItem, errors: []}
            else
                {listItem: nil, errors: listItem.errors.full_messages}
            end
        end
    end
end