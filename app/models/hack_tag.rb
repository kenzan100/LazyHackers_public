class HackTag < ActiveRecord::Base
  has_many :hacks_scopes
  has_many :scopes, :through => :hacks_scopes
  
  has_many :progres
  has_many :users, :through => :progres
  
  def self.related_hack_tags(hack_tags)
  end
  
  def self.check_intersection(hack_tags)
    
    users = []
    a_users = []
    b_users = []
    followers = []
    
    hack_tags.each_with_index do |hack_tag, i|    
      if (i+1)%2 == 1
        a_users = []
        hack_tag.users.each do |user|
          a_users.push(user)
        end
        followers = followers | a_users
      else
        b_users = []
        hack_tag.users.each do |user|
          b_users.push(user)
        end
        followers = followers | b_users
      end
      if i == 0
        users = a_users
      else
        users = a_users & b_users
      end
    end
    
    return[users, followers]
  end
  
end
