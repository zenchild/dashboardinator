class Portal < ActiveRecord::Base
  attr_accessible :description, :name

  validates :name, :presence => true
  validates :name, :uniqueness => true

  has_many :portlets
  has_many :metrics, :through => :portlets
end
