class HackTag < ActiveRecord::Base
  has_many :hacks_scopes
  has_many :scopes, :through => :hacks_scopes
  
  has_many :progres
  has_many :users, :through => :progres
end
