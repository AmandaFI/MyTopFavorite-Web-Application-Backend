module Mutations
    class UpdateList < BaseMutation
        description "Updates a list."

        argument :id, Integer, required: true 
        argument :title, String, required: false
        argument :draft, Boolean, required: false

        validates required: {
            one_of: [:title, :draft],
            message: 'Please supply some property to be updated.'
        }

        field :list, Types::ListType, null: false  
        field :errors, [String], null: false

        def resolve(id:, title: nil, draft: nil)
            require_authentication!
            
            list = List.find(id)

            updated_attrs = {}
            updated_attrs.merge! title: title unless title.nil?
            updated_attrs.merge! draft: draft unless draft.nil?
            
            if list.update(updated_attrs)
                {list: list, errors: []}
            else
                {list: nil, errors: list.errors.full_messages}
            end
        end
    end
end