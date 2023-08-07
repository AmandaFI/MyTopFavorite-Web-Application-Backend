module Mutations
    class CreateList < BaseMutation
        description "Creates a new list for the current user."

        # parametros (dto)
        argument :title, String, required: true
        argument :categoryId, Integer, required: true 
        argument :draft, Boolean, required: false, default_value: true
        
        # retornos
        field :list, Types::ListType, null: false
        field :errors, [String], null: false

        def resolve(title:, categoryId:, draft:)
            require_authentication!

            current_user.lists << List.new({title: title, category_id: categoryId, draft: draft})
            list = current_user.lists.last

            if list.save
                {list: list, errors: []}
            else
                {list: nil, errors: list.errors.full_messages}
            end
        end
    end
end