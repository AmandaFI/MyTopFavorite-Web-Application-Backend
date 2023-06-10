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
#  index_lists_on_created_at   (created_at)
#  index_lists_on_user_id      (user_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id) ON DELETE => restrict
#  user_id      (user_id => users.id) ON DELETE => cascade
#
require "test_helper"

class ListTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
