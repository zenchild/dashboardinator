class Portlet < ActiveRecord::Base
  attr_accessible :metric_id, :display_order, :portal_id
  validates :metric_id, :portal_id, :presence => true

  belongs_to :portal
  belongs_to :metric
end
