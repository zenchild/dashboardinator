class Metric < ActiveRecord::Base
  attr_accessible :description, :name, :snippet
  validates :name, :snippet, :presence => true
  validates :name, :uniqueness => true
end
