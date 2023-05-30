# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string           not null
#  encrypted_password :string           not null
#  name               :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_and_belongs_to_many :followers, foreign_key: :follower_id, association_foreign_key: :followed_id, class_name: "User"
  has_and_belongs_to_many :followed_users, foreign_key: :followed_id, association_foreign_key: :follower_id, class_name: "User"
  has_many :lists
  has_and_belongs_to_many :liked_lists, class_name: "List"


  validates :name, :email, :encrypted_password, presence: true

  # singleton method --> método de classe (ruby em tese possui somente metodo de instancia pois tecnicamente toda classe é uma instancia de outra classe)
  def self.authenticate(email, password)
    # Todas as versões abaixo funcionam
    # User.exists? email: email, password: password
    # exists? email: email, encrypted_password: password
    User.find_by(email: email, encrypted_password: password) 

  end
end
