class PortalsController < ApplicationController
  def index
    @portal = Portal.new
    @out_portals = current_user.portals.all
    @purpose = "Create"
  end

  def create
    #render :text => params.inspect
    Portal.create params[:portal]
    redirect_to :back
  end

  def edit
    @purpose = "Edit"
    @portal = Portal.find params[:id]
    @portlets = @portal.metrics
  end

  def update
    portal = Portal.find params[:id]
    if portal.update_attributes params[:portal]
      redirect_to portals_path
    else 
      redirect_to :back, :notice => "Validation Error"
    end
  end

  def destroy
    Portal.destroy params[:id]
    redirect_to :back, :notice => "Portal Deleted"
  end

  def show
    @portal = Portal.find params[:id]
    @metrics = Metric.find_by_sql("select a.id, display_order, metric_id, name, snippet from portlets a, metrics b where a.metric_id = b.id and a.portal_id = #{params[:id]} order by display_order")
  end

end
