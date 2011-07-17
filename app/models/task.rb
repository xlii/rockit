class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :resolution
  
  validates :resolution, :presence => true
  validates :project, :presence => true
  validates :name, :presence => true
end
