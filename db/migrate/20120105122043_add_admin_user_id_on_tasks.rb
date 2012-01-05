class AddAdminUserIdOnTasks < ActiveRecord::Migration
  def self.up
  	add_column :tasks, :admin_user_id, :integer
  end

  def self.down
  	remove_column :tasks, :admin_user_id
  end
end
