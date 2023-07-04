# frozen_string_literal: true

module Types
  class ListType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :draft, Boolean, null: false

    field :category, Types::CategoryType, null: false
    field :user, Types::UserType, null: false
    field :items, Types::ListItemType, null: true

    field :likers_count, Integer, null: true
    # field :liked_by_current_user, Integer, null: true

    def likers_count
      object.likers.count
    end

    # Resolver como acessar current_user
    # def liked_by_current_user
   
    #    object.likers.where(id: @instance_options[:current_user].id).present?
       
    #  end
  end
end
