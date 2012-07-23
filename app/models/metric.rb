class Metric < ActiveRecord::Base
  attr_accessible :description, :name, :snippet
  validates :name, :snippet, :presence => true
  validates :name, :uniqueness => true

  has_many :portlets
  has_many :portals, :through => :portlets
end
