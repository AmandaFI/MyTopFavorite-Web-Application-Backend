module Types
  class MutationType < Types::BaseObject
    field :create_category, mutation: Mutations::CreateCategory
    field :delete_category, mutation: Mutations::DeleteCategory
    field :update_category, mutation: Mutations::UpdateCategory
    field :login, mutation: Mutations::Login
    field :create_list, mutation: Mutations::CreateList
    field :delete_list, mutation: Mutations::DeleteList
    field :dislike_list, mutation: Mutations::DislikeList
    field :like_list, mutation: Mutations::LikeList
    field :delete_list_item, mutation: Mutations::DeleteListItem
    field :delete_user, mutation: Mutations::DeleteUser
    field :unfollow_user, mutation: Mutations::UnfollowUser
    field :follow_user, mutation: Mutations::FollowUser
    field :create_list_item, mutation: Mutations::CreateListItem
    field :update_list_item, mutation: Mutations::UpdateListItem
    field :update_list, mutation: Mutations::UpdateList
    field :create_user, mutation: Mutations::CreateUser
    field :update_user, mutation: Mutations::UpdateUser
    field :find_user_by_name, mutation: Mutations::FindUserByName
  end
end
