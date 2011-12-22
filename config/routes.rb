Rockit::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, :controllers => { :omniauth_callbacks => "admin_users/omniauth_callbacks" }
  
  devise_scope :admin_user do
  	get '/admin_users/auth/:provider' => 'admin_users/omniauth_callbacks#passthru'
		get "/admin_users/sign_out" => "devise/sessions#destroy"
	end
  
  root :to => redirect('/admin')

end
