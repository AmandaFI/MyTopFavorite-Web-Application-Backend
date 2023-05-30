# == Schema Information
#
# Table name: lists
#
#  id          :integer          not null, primary key
#  title       :string(128)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_lists_on_category_id  (category_id)
#  index_lists_on_user_id      (user_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id) ON DELETE => restrict
#  user_id      (user_id => users.id) ON DELETE => cascade
#
class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :likers_count, :items_count

  belongs_to :category
  # belongs_to :user
  # has_many :items, class_name: "ListItem"

  def likers_count
    object.likers.count
  end

  def items_count
    object.items.count
  end
end
