module Mutations
    class DeleteCategory < BaseMutation
        description "Deletes a category."

        argument :id, ID, required: true   

        field :category, Types::CategoryType, null: false   # coisas retornadas
        field :errors, [String], null: false

        def resolve(id:)
            category = Category.find(id)

            if category.destroy
                {category: category, errors: []}
            else
                {category: nil, errors: category.errors.full_messages}
            end
        end
    end
end