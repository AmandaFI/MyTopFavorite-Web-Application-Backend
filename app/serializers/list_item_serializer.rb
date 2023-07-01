# == Schema Information
#
# Table name: list_items
#
#  id                      :integer          not null, primary key
#  details                 :string
#  external_api_identifier :string           not null
#  image_url               :string
#  rank                    :integer          not null
#  title                   :string           not null
#  user_comment            :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  list_id                 :integer          not null
#
# Indexes
#
#  index_list_items_on_list_id  (list_id)
#
# Foreign Keys
#
#  list_id  (list_id => lists.id) ON DELETE => cascade
#
class ListItemSerializer < ActiveModel::Serializer
  attributes :id, :external_api_identifier, :image_url, :details, :rank, :title, :user_comment

  belongs_to :list #, serializer: SimplifiedListSerializer
end
