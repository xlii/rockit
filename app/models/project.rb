class Project < ActiveRecord::Base
  has_paper_trail
  validates :name, :presence => true
  has_many :tasks
end
