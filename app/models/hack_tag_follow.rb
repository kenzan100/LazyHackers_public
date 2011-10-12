class HackTagFollow < ActiveRecord::Base
  belongs_to :hack_tag
  
  def self.check_exit
    HackTagFollow.all.each do |htf|
      unless HackTag.exists?(:id => htf.greater.hack_tag_id)
        htf.destroy
      end
      unless HackTag.exists?(:id => htf.hack_tag_id)
        htf.destroy
      end
    end
  end
end
