class UsersHacktag < ActiveRecord::Base
  belongs_to :user
  belongs_to :hack_tag
  
  def self.update_from_progres(progres)
    progres.each do |progre|
      unless UsersHacktag.exists?(:user_id=>progre.user_id, :hack_tag_id=>progre.hack_tag_id)
        users_hacktag = UsersHacktag.new(:user_id=>progre.user_id, :hack_tag_id=>progre.hack_tag_id)
        users_hacktag.save
      end
      
      if progre.dropout == true
        UsersHacktag.where(:user_id=>progre.user_id, :hack_tag_id=>progre.hack_tag_id).each do |uht|
          uht.destroy
        end
      end
    end
  end
end
