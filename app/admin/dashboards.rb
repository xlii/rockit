ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #

	section "Recent Task Activities" do		
    table_for Version.where(:item_type => "Task").order("created_at desc").limit(20) do
      column :item do |version|
      	task = version.item
      	if task.nil?
      		"##{version.item_id}"
      	else
	        link_to "##{version.item_id}", admin_task_path(version.item)
	      end
      end
      
      column :whodunnit do |version|
      	user = AdminUser.find(version.whodunnit.to_i)
      	"#{user.first_name} #{user.last_name}"
      end
      
      column :event do |version|
      	msg = "Task was "
      	if version.event == "create"
      		msg += "created"
      	elsif version.event == "update"
      		msg += "updated at fields: #{version.changeset.keys.to_sentence}"
      	else
      		msg += "deleted"
      	end
      	msg
      end
      column :created_at
    end   
	end
end
