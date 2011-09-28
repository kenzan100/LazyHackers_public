class UsersScope < ActiveRecord::Base
  belongs_to :user
  belongs_to :scope
end
