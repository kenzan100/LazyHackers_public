class Progre < ActiveRecord::Base
  belongs_to :hack_tag
  belongs_to :user
  belongs_to :scope
  
  def self.one_shallow_point_progres(scope_id, user_id)
    progres = []
    scope = Scope.find(scope_id)
    user = User.find(user_id)
    scope.hack_tags.last.hack_tag_follows.each do |htf|
      one_shallow_hack_tag = HackTag.find(htf.greater_hack_tag_id)
      if user.progres.exists?(:hack_tag_id=>one_shallow_hack_tag.id, :success=>true)
        progres += user.progres.where('scope_id != ?', scope_id).where(:hack_tag_id=>one_shallow_hack_tag.id, :success=>true).order('done_when DESC').limit(5)
      end
    end
    
    return progres
  end
  
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
  
  def self.erase_all_dropout
    Progre.update_all(:dropout=>false)
  end
  
  def self.check_dropout(users, scopes)
    six_daysago = Date.today - 6.days
    today = Date.today
    hangin_theres = []
    users.each do |user|
      scopes.each do |scope|
        hangin_there = 0
        last_done = user.progres.where(:scope_id=>scope.id, :success=>true).last
        
        if last_done.present?
          (six_daysago..today).each do |each_day|
            if each_day.to_s == last_done.done_when.strftime("%Y-%m-%d")
              hangin_there = 1
            end
          end
        end
                      
        if hangin_there == 0
          user.progres.where(:scope_id=>scope.id).update_all(:dropout => true)
        else
          user.progres.where(:scope_id=>scope.id).each do |recover|
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
  
end
