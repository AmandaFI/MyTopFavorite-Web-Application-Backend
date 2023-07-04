module Mutations
    class CreateCategory < BaseMutation
        description "Creates a new category."

        # parametros (dto)
        argument :name, String, required: true   

        # coisas retornadas
        field :category, Types::CategoryType, null: false   # coisas retornadas
        field :errors, [String], null: false

        # função chamada com os parametros recebidos e que retornará os fields definidos
        def resolve(name:)
            category = Category.new(name: name)

            if category.save
                {category: category, errors: []}
            else
                {category: nil, errors: category.errors.full_messages}
            end
        end
    end
end