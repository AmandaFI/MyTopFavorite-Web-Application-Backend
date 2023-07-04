module Mutations
    class UpdateCategory < BaseMutation
        description "Updates a category."

        argument :id, ID, required: true   
        argument :name, String, required: true   

        field :category, Types::CategoryType, null: false  
        field :errors, [String], null: false

        def resolve(id:, name:)
            category = Category.find(id)

            updated_attrs = {name: name}

            if category.update(updated_attrs)
                {category: category, errors: []}
            else
                {category: nil, errors: category.errors.full_messages}
            end
        end
    end
end