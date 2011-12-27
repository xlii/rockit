class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me
  
  def self.find_for_open_id(access_token, signed_in_resource=nil)
		data = access_token.info		
		if user = AdminUser.where(:email => data["email"]).first		
      user.update_attributes :first_name => data["first_name"], :last_name => data["last_name"] if user.first_name != data["first_name"] or user.last_name != data["last_name"]
		  user
		else
		  AdminUser.create!(:email => data["email"], :password => Devise.friendly_token[0,20], :first_name => data["first_name"], :last_name => data["last_name"])
		end
	end
	
	def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
        user.first_name = data["first_name"]
        user.last_name = data["last_name"]
      end
    end
  end
  
  def name
  	name = ''
  	name = first_name + ' ' + last_name unless first_name.nil? or last_name.nil?
  	name
  end
end
