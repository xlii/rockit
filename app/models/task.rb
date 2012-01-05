class Task < ActiveRecord::Base
  has_paper_trail
  belongs_to :project
  belongs_to :resolution
  belongs_to :admin_user
  
  validates :resolution, :presence => true
  validates :project, :presence => true
  validates :name, :presence => true
end
