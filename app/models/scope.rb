class Scope < ActiveRecord::Base
  has_many :hacks_scopes
  has_many :hack_tags, :through => :hacks_scopes
  
  has_many :users_scopes
  has_many :users, :through => :users_scopes
  
  def self.create_one_more_depth_scope(given_hack_tags)
    creating_scope = Scope.new
    creating_scope.save
    
    given_hack_tags.each do |hack_tag|
      creating_hacks_scope = HacksScope.new(:scope_id=>creating_scope.id, :hack_tag_id=>hack_tag.id)
      creating_hacks_scope.save
      if hack_tag.image_url.present?
        creating_scope.image_url = hack_tag.image_url
        creating_scope.save
      end
    end
      
    return creating_scope
  end
end
