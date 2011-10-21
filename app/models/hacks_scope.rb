class HacksScope < ActiveRecord::Base
  belongs_to :hack_tag
  belongs_to :scope
  
  def self.change_belonging_hack_tags(scope_id, original_hack_tag_id, new_hack_tag_id)
    HacksScope.where(:scope_id=>scope_id, :hack_tag_id=>original_hack_tag_id).update_all(:hack_tag_id=>new_hack_tag_id)
  end
end
