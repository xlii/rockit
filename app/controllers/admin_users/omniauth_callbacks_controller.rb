class AdminUsers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def passthru
		render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
	end
  
  def google
  	email = request.env["omniauth.auth"].info["email"]
 		split_email = email.split('@') 		
		domain = split_email[1].to_s
		if domain == 'fortito.com.br'
		  @user = AdminUser.find_for_open_id(request.env["omniauth.auth"], current_admin_user)
		  if @user.persisted?
		    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
		    sign_in_and_redirect @user, :event => :authentication
		  else
		    session["devise.google_data"] = request.env["omniauth.auth"]
		    redirect_to new_admin_user_session_url
		  end
		else
			flash[:notice] = "Only fortito users can access the system"
			redirect_to new_admin_user_session_url
		end
  end
end
