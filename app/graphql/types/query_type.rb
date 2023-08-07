module Types
  class QueryType < Types::BaseObject

    DEFAULT_PER_PAGE = 3
    MAX_PER_PAGE = 99

    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.


    # --------------------------------------- Category ---------------------------------------

    field :categories, [CategoryType], "Returns all platform categories.", null: false
    def categories
      require_authentication!
      Category.all
    end

    field :category, CategoryType, "Returns specific category.", null: false do
      argument :id, ID, required: true
    end
    def category(id:)
      require_authentication!
      Category.find(id)
    end

    # --------------------------------------- Session ---------------------------------------

    field :login_status, UserType, "Returns the logged user.", null: true
    def login_status
      require_authentication!

      current_user
    end

    # --------------------------------------- User ---------------------------------------

    field :users, [UserType], "Returns all registered users.", null: true
    def users
      require_authentication!

      User.all
    end

    field :user, UserType, "Returns specific user.", null: false do
      argument :id, ID, required: true
    end
    def user(id:)
      require_authentication!
      
      User.find(id)
    end

    field :loggedUserFollowedUsers, [UserType], "Returns all users followed by the logged user.", null: true
    def loggedUserFollowedUsers
      require_authentication!

      current_user.followed_users
    end

    field :loggedUserFollowers, [UserType], "Returns all users that follow the logged user.", null: true
    def loggedUserFollowers
      require_authentication!

      current_user.followers
    end

    field :checkFollowing, Boolean, "Checks if the logged user follows a given user.", null: false do
      argument :id, ID, required: true
    end
    def checkFollowing
      require_authentication!

      followed_user = current_user.followed_users.find(params[:id])
      if followed_user
        true
      else
        false
      end
    end

    field :followedUserLists, [UserType], "Returns lists from the users followed by the logged user.", null: true
    def followedUserLists
      require_authentication!

      lists = current_user.followed_users.flat_map do |user| 
        user.lists.published.order(created_at: :desc).limit(per_page).offset(per_page * (page - 1))
      end

      lists
    end

    # --------------------------------------- List ---------------------------------------

    field :list, ListType, "Returns specific list.", null: false do
      argument :id, ID, required: true
    end
    def list(id:)
      require_authentication!

      List.find(id)
    end

    field :loggedUserLists, [ListType], "Returns all logged user lists.", null: true
    def loggedUserLists
      require_authentication!

      current_user.lists
    end

    field :loggedUserDraftLists, [ListType], "Returns all logged user draft lists.", null: true
    def loggedUserDraftLists
      require_authentication!

      current_user.lists.draft.order(updated_at: :desc)
    end

    field :userPublishedLists, [ListType], "Returns all published lists from a specific user.", null: true do
      argument :id, ID, required: true
      argument :page, Integer,
        required: false,
        default_value: 1,
        validates: { numericality: { greater_than_or_equal_to: 1 } }
      argument :per_page, Integer,
        required: false,
        default_value: DEFAULT_PER_PAGE,
        validates: {
          numericality: {
            greater_than_or_equal_to: 1,
            less_than_or_equal_to: MAX_PER_PAGE
          }
        }
    end
    def userPublishedLists(id:, page:, per_page:)
      require_authentication!

      user = User.find(id)
      if user
        user.lists.published.order(updated_at: :desc).limit(per_page).offset(per_page * (page - 1))
      end
    end

    # --------------------------------------- ListItem ---------------------------------------

    field :listItem, ListItemType, "Returns specific list item.", null: true do
      argument :id, ID, required: true
    end
    def listItem(id:)
      require_authentication!

      ListItem.find(id)
    end

    field :listItems, [ListItemType], "Returns items from specific list.", null: true do
      argument :id, ID, required: true
    end
    def listItems(id:)
      require_authentication!

      List.find(id).items
    end
  end
end
