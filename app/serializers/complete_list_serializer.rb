class CompleteListSerializer < ActiveModel::Serializer
  attributes :id, :title, :likers_count, :draft, :created_at, :liked_by_current_user
  belongs_to :category
  belongs_to :user, serializer: BasicUserSerializer
  has_many :items, class_name: "ListItem"

  def likers_count
    object.likers.count
  end

  def liked_by_current_user
   # !!object.likers.find(@instance_options[:current_user].id)

    object.likers.where(id: @instance_options[:current_user].id).present?
    
  end
end
