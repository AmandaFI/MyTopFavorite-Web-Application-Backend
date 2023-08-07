module Types
  class MutationType < Types::BaseObject
    # ---------- Category ----------
    field :create_category, mutation: Mutations::CreateCategory
    field :update_category, mutation: Mutations::UpdateCategory
    field :delete_category, mutation: Mutations::DeleteCategory
    # ---------- Session ----------
    field :login, mutation: Mutations::Login
    # ---------- List ----------
    field :create_list, mutation: Mutations::CreateList
    field :update_list, mutation: Mutations::UpdateList
    field :delete_list, mutation: Mutations::DeleteList
    field :like_list, mutation: Mutations::LikeList
    field :dislike_list, mutation: Mutations::DislikeList
    # ---------- ListItem ----------
    field :create_list_item, mutation: Mutations::CreateListItem
    field :update_list_item, mutation: Mutations::UpdateListItem
    field :delete_list_item, mutation: Mutations::DeleteListItem
    # ---------- User ----------
    field :create_user, mutation: Mutations::CreateUser
    field :update_user, mutation: Mutations::UpdateUser
    field :delete_user, mutation: Mutations::DeleteUser
    field :follow_user, mutation: Mutations::FollowUser
    field :unfollow_user, mutation: Mutations::UnfollowUser
    field :find_user_by_name, mutation: Mutations::FindUserByName
  end
end
