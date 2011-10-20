class HackTag < ActiveRecord::Base
  has_many :hacks_scopes
  has_many :scopes, :through => :hacks_scopes
  
  has_many :progres
  has_many :users_hacktags
  has_many :users, :through => :users_hacktags
  
  has_many :hack_tag_follows
    
  def self.check_exit(hack_tags)
    hack_tags.each do |hack_tag|
      dropout = 0
      hack_tag.users.each do |user|
        if user.progres.exists?(:hack_tag_id=>hack_tag.id, :dropout=>true)
          dropout += 1
        end
      end

      if hack_tag.users.count == dropout
        hack_tag.destroy
      end
    end
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
