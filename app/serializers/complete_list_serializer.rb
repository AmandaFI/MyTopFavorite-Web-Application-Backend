class CompleteListSerializer < ActiveModel::Serializer
  attributes :id, :title, :likers_count
  belongs_to :category
  belongs_to :user
  has_many :items, class_name: "ListItem"

  def likers_count
    object.likers.count
  end
end
