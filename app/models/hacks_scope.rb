class HacksScope < ActiveRecord::Base
  belongs_to :hack_tag
  belongs_to :scope
end
