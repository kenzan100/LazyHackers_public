class Progre < ActiveRecord::Base
  belongs_to :hack_tag
  belongs_to :user
  
  def self.check_intersection(hack_tags)
    
    progres = []
    a_progres = []
    b_progres = []
    feed = []
    
    hack_tags.each_with_index do |hack_tag, i|    
      if (i+1)%2 == 1
        a_progres = []
        hack_tag.progres.each do |progre|
          a_progres.push(progre)
        end
        feed = feed | a_progres
      else
        b_progres = []
        hack_tag.progres.each do |progre|
          b_progres.push(progre)
        end
        feed = feed | b_progres
      end
      if i == 0
        progres = a_progres
      else
        progres = a_progres & b_progres
      end
    end
    
    return[progres, feed]
    
  end
  
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
