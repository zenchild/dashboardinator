class PortletsController < ApplicationController
  def index
    #render :text => params.inspect
    @portlet = Portlet.new
    @this_portal = Portal.find(params[:portal_id])
    @metrics = @this_portal.metrics
    @added_ids = []
    @metrics.each {|m| @added_ids.push m['id']}
    @all_metrics = Metric.all
    @all_metrics.delete_if {|i| @added_ids.include? i['id']}
  end

  def create
    Portlet.create(:metric_id => params[:portlet][:metric_id], :portal_id => params[:portal_id], :order => 0)
    redirect_to :back
    #render :text => params.inspect
  end

  def destroy
    @p = Portlet.where("metric_id = ? AND portal_id = ?", params[:id], params[:portal_id])
    Portlet.destroy @p
    redirect_to :back
    #render :text => params.inspect
  end
end
