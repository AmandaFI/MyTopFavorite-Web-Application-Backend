module Types
  class MutationType < Types::BaseObject
    field :create_category, mutation: Mutations::CreateCategory
    field :delete_category, mutation: Mutations::DeleteCategory
    field :update_category, mutation: Mutations::UpdateCategory
    field :login, mutation: Mutations::Login
  end
end
