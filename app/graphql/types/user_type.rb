# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    # password_digest removido
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false

    filed :lists, [Types::ListType], null: true
    field :followers, [Types::UserType], null: true
    field :followed_users, [Types::UserType], null: true
    field :liked_lists, [Types::ListType], null: true

    field :list_count, Integer, null: true
    field :followers_count, Integer, null: true
    field :followed_users_count, Integer, null: true

    def list_count
      object.lists.count
    end
  
    def followers_count
      object.followers.count
    end
  
    def followed_users_count
      object.followed_users.count
    end
    
  end
end
