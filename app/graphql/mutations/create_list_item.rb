module Mutations
    class CreateListItem < BaseMutation
        description "Creates a new list item."

        # parametros (dto)
        argument :list_id, Integer, required: true 
        argument :title, String, required: true
        argument :external_api_identifier, String, required: true
        argument :rank, Integer, required: true
        argument :image_url, String, required: false, default_value: ''
        argument :details, String, required: false, default_value: ''
        argument :user_comment, String, required: false, default_value: ''
        
        # retornos
        field :listItem, Types::ListItemType, null: false
        field :errors, [String], null: false

        def resolve(list_id:, title:, external_api_identifier:, rank:, image_url:, details:, user_comment:)
            require_authentication!

            list = List.find(list_id)
            if list
                list.items << ListItem.new(title: title, external_api_identifier: external_api_identifier, rank: rank, image_url: image_url, details: details, user_comment: user_comment)
                list_item = list.items.last
                if list_item.save
                    {listItem: list_item, errors: []}
                else
                    {listItem: nil, errors: list_item.errors.full_messages}
                end
            else
                {listItem: nil, errors: list.errors.full_messages}
            end
        end
    end
end