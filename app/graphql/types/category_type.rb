# frozen_string_literal: true

# null: false significa que o atributo sempre existe no banco, o cliente pode pedir que sermpre tera um valor
module Types
  class CategoryType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
  end
end
