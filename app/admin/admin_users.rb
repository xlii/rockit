ActiveAdmin.register AdminUser do
  index do
    column :id do |admin_user|
      link_to admin_user.id, admin_admin_user_path(admin_user)
    end
    
    column :email
    column :last_sign_in_at
    column "", default_actions
  end

  form do |f|
     f.inputs "User edition" do
       f.input :email
       f.input :password
       f.input :password_confirmation
     end
     f.buttons
   end
  
end
