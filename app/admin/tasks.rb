ActiveAdmin.register Task do
  index do
  	column :id
    column :project
    column :name do |task|
    	link_to task.name, admin_task_path(task)
    end
    column :resolution
    column :priority    
    column :created_at
    default_actions
  end
end
