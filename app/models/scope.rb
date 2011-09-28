class Scope < ActiveRecord::Base
  has_many :hacks_scopes
  has_many :hack_tags, :through => :hacks_scopes
  
  has_many :users_scopes
  has_many :users, :through => :users_scopes
end
