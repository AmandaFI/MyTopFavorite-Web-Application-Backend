# == Schema Information
#
# Table name: list_items
#
#  id                      :integer          not null, primary key
#  external_api_identifier :string           not null
#  metadata                :json
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
class ListItem < ApplicationRecord
  belongs_to :list
end
