class RemoveNotUsedAdminUsers < ActiveRecord::Migration
  def self.up
  	AdminUser.all.each do |admin_user|
  		split_email = admin_user.email.split('@') 		
			domain = split_email[1].to_s
			admin_user.destroy unless domain == 'fortito.com.br'
  	end
  end

  def self.down
  end
end
