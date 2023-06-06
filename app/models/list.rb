# == Schema Information
#
# Table name: lists
#
#  id          :integer          not null, primary key
#  draft       :boolean          default(TRUE), not null
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
class List < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :items, class_name: "ListItem"
  has_and_belongs_to_many :likers, class_name: "User"

  validates :title, presence: true

  scope :draft, -> { where draft: true }
  scope :published, -> { where draft: false }


  def items_count   #metodo de instancia
    # o mesmo que self.items.count
    items.count
  end
end
