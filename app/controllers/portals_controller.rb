=begin
  Copyright 2012 Robert Hart <sasallys@yahoo.co.uk>

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
=end

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
