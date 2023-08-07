module Mutations
    class UpdateUser < BaseMutation
        description "Updates a user."

        argument :id, Integer, required: true 
        argument :email, String, required: false
        argument :password, String, required: false 
        argument :name, String, required: false

        validates required: {
            one_of: [:email, :password, :name],
            message: 'Please supply some property to be updated.'
        }

        field :user, Types::UserType, null: false  
        field :errors, [String], null: false

        def resolve(id:, email: nil, password: nil, name: nil)
            require_authentication!
            
            user = User.find(id)

            updated_attrs = {}
            updated_attrs.merge! email: email unless email.nil?
            updated_attrs.merge! password: password unless password.nil?
            updated_attrs.merge! name: name unless name.nil?

            
            if user.update(updated_attrs)
                {user: user, errors: []}
            else
                {user: nil, errors: user.errors.full_messages}
            end
        end
    end
end