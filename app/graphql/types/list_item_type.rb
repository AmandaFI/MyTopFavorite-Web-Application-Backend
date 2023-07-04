# frozen_string_literal: true

module Types
  class ListItemType < Types::BaseObject
    field :id, ID, null: false
    field :external_api_identifier, String, null: false
    field :title, String, null: false
    field :rank, Integer, null: false
    field :user_comment, String
    field :image_url, String
    field :details, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false

    field :lists, Types::ListType, null: false
  end
end
