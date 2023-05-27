class ListItemSerializer < ActiveModel::Serializer
  attributes :id, :external_api_identifier, :metadata, :rank, :title, :user_comment

  belongs_to :list
end
