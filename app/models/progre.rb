class Progre < ActiveRecord::Base
  belongs_to :hack_tag
  belongs_to :user
  
  def self.create_all_success(hack_tags, user_id, scope_id)
    hack_tags.each do |hack_tag|
      progre = Progre.new(:hack_tag_id=>hack_tag.id, :done_when=>Time.now)
      progre.success = true
      progre.scope_id = scope_id
      progre.user_id = user_id
      progre.save
    end
  end
  
  def self.create_all_success_with_comment(hack_tags, user_id, scope_id, comment)
    hack_tags.each do |hack_tag|
      progre = Progre.new(:hack_tag_id=>hack_tag.id, :done_when=>Time.now)
      progre.success = true
      progre.scope_id = scope_id
      progre.user_id = user_id
      progre.comment = comment
      progre.save
    end
  end
  
  def self.check_dropout(users, hack_tags)
    two_daysago = Date.today - 2.days
    today = Date.today
    hangin_theres = []
    users.each do |user|
      hack_tags.each do |hack_tag|
        hangin_there = 0
        last_done = user.progres.where(:hack_tag_id=>hack_tag.id).order('done_when DESC').first
        if last_done.present?
          (two_daysago..today).each do |each_day|
            if each_day.to_s == last_done.done_when.strftime("%Y-%m-%d")
              hangin_there = 1
            end
                      
            if hangin_there == 0
              dropout_record = last_done.clone
              dropout_record.dropout = true
              dropout_record.save
            else
              user.progres.where(:hack_tag_id=>hack_tag.id).each do |recover|
                recover.dropout = false
                recover.save
              end
            end
            
            hangin_theres.push(hangin_there)
          end
        end
      end
    end
    
    return hangin_theres
  end
  
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
