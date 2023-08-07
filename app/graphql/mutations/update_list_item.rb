module Mutations
    class UpdateListItem < BaseMutation
        description "Updates a list item."

        argument :id, Integer, required: true 
        argument :title, String, required: false
        argument :external_api_identifier, String, required: false
        argument :rank, Integer, required: false
        argument :image_url, String, required: false
        argument :details, String, required: false
        argument :user_comment, String, required: false

        validates required: {
            one_of: [:title, :external_api_identifier, :rank, :image_url, :details, :user_comment],
            message: 'Please supply some property to be updated.'
        }

        field :listItem, Types::ListItemType, null: false  
        field :errors, [String], null: false

        def resolve(id:, title: nil, external_api_identifier: nil, rank: nil, image_url: nil, details: nil, user_comment: nil)
            require_authentication!
            
            list_item = ListItem.find(id)

            updated_attrs = {}
            updated_attrs.merge! title: title unless title.nil?
            updated_attrs.merge! external_api_identifier: external_api_identifier unless external_api_identifier.nil?
            updated_attrs.merge! rank: rank unless rank.nil?
            updated_attrs.merge! image_url: image_url unless image_url.nil?
            updated_attrs.merge! details: details unless details.nil?
            updated_attrs.merge! user_comment: user_comment unless user_comment.nil?


            if list_item.update(updated_attrs)
                {listItem: list_item, errors: []}
            else
                {listItem: nil, errors: list_item.errors.full_messages}
            end
        end
    end
end