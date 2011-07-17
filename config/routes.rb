Rockit::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  
  root :to => redirect('/admin')
  
  devise_scope :admin_user do
      get '/admin/logout', :to => 'active_admin/devise/sessions#destroy'
  end

end
