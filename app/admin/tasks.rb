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
  
  show do
    panel 'Task' do
      attributes_table_for task  do 
        row :id
        row :project
        row :name
        row(:description) { simple_format task.description }
        row :admin_user
        row :resolution
        row :priority
        row(:created_at) { time_ago_in_words task.created_at }
        row(:updated_at) { time_ago_in_words task.updated_at }        
      end
    end
  end
end
