class PortalsController < ApplicationController
  def index
    @portal = Portal.new
    @out_portals = current_user.portals.all
  end

  def create
    #render :text => params.inspect
    Portal.create params[:portal]
    redirect_to :back
  end

  def edit
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
    @metrics = @portal.metrics
  end

end
