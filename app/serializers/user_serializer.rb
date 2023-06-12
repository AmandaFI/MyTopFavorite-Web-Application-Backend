# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  name       :string           not null
#  password   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :followers_count, :followed_users_count, :list_count, :created_at

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
