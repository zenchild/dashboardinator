class PortalsController < ApplicationController
  def index
    @portal = Portal.new
    @out_portals = Portal.all
  end

  def create
    Portal.create params[:portal]
    redirect_to :back
  end

  def edit
    @portal = Portal.find params[:id]
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

end
