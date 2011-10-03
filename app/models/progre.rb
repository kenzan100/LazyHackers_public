class Progre < ActiveRecord::Base
  belongs_to :hack_tag
  belongs_to :user
  
  def self.from_updated_at_to_done_when
    Progre.all.each do |progre|
      progre.done_when = progre.updated_at
      progre.save
    end
  end
  
  def self.from_party_id_to_hack_tag_id
    Progre.all.each do |progre|
      pid = progre.party_id
      PartiesHacktag.where(:party_id=>pid).each_with_index do |p_to_tag, i|
        if i == 0
          progre.hack_tag_id = p_to_tag.hack_tag_id
          progre.save
        else
          clone_progre = progre.clone
          clone_progre.hack_tag_id = p_to_tag.hack_tag_id
          clone_progre.save
        end
      end
    end
  end
end
