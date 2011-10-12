class Progre < ActiveRecord::Base
  belongs_to :hack_tag
  belongs_to :user
  belongs_to :scope
  
  def self.destroy_notification(comment)
    Progre.where(:comment=>comment).destroy_all
  end
  
  def self.create_notification(users, comment, inst_flag)
    noti_hack_tag = HackTag.where(:name=>'notification').first
    
    users.each do |user|
      noti_progre_for_this_user = Progre.new(:user_id=>user.id, :hack_tag_id=>noti_hack_tag.id, :success=>false, :comment=>comment)
      if inst_flag == 1
        noti_progre_for_this_user.instruction_flag = true
      end
      noti_progre_for_this_user.save
    end
  end
  
  def self.create_all_success(hack_tags, user_id, scope_id)
    success_progres = []
    hack_tags.each do |hack_tag|
      progre = Progre.new(:hack_tag_id=>hack_tag.id, :done_when=>Time.now)
      progre.success = true
      progre.scope_id = scope_id
      progre.user_id = user_id
      progre.save
      success_progres.push(progre)
    end
    return success_progres
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
    six_daysago = Date.today - 6.days
    today = Date.today
    hangin_theres = []
    users.each do |user|
      hack_tags.each do |hack_tag|
        hangin_there = 0
        last_done = user.progres.where(:hack_tag_id=>hack_tag.id, :success=>true).last
        
        if last_done.present?
          (six_daysago..today).each do |each_day|
            if each_day.to_s == last_done.done_when.strftime("%Y-%m-%d")
              hangin_there = 1
            end
          end
        end
                      
        if hangin_there == 0
          user.progres.where(:hack_tag_id=>hack_tag.id).update_all(:dropout => true)
        else
          user.progres.where(:hack_tag_id=>hack_tag.id).each do |recover|
            recover.dropout = false
            recover.save
          end
        end
        
      end
    end
    
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
  
  def self.from_party_id_to_scope_id
    Progre.all.each do |progre|
      #プログレのパーティーIDをパーティーズハックタグに照らし合わせて、スコープIDに値を入れる
      if PartiesScope.exists?(:party_id=>progre.party_id)
        progre.scope_id = PartiesScope.where(:party_id=>progre.party_id).first.scope_id
        progre.save
      end
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
