class User < ActiveRecord::Base
  
  has_many :progres
  has_many :hack_tags, :through => :progres
  
  has_many :users_scopes
  has_many :scopes, :through => :users_scopes
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  :omniauthable
  devise :trackable, :omniauthable,
   :database_authenticatable, :registerable,
   :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :image_url, :password, :password_confirmation, :remember_me, :uid, :screen_name, :access_token, :access_secret

  def self.find_for_user_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']

    if user = User.find_by_uid(access_token['uid'].to_i)
      user
    else
      user = User.new({
        :uid => access_token['uid'].to_i,
        :screen_name => data['screen_name'],
        :access_token => access_token['credentials']['token'],
        :access_secret => access_token['credentials']['secret']
        })
      user.save(:validate => false)
    end
  end
  
end
