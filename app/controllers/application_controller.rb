class ApplicationController < ActionController::Base
  protect_from_forgery

  def user_for_paper_trail
    current_admin_user
  end

  layout :layout_by_resource

  protected

  def layout_by_resource
    if devise_controller? and params[:action] == 'new'
    	puts 'action'+params.inspect
      "active_admin_logged_out"
    else
      "application"
    end
  end
 
end
