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
    @orders = Portlet.select(:display_order).where(:portal_id => params[:portal_id])
    if @orders == []
      @fake = Hash.new
      @fake[:display_order] = 0
      @orders << @fake
    end
    @max_order = @orders.max[:display_order]
    @new_order = @max_order + 1
    Portlet.create(:metric_id => params[:portlet][:metric_id], :portal_id => params[:portal_id], :display_order => @new_order)
    redirect_to :back
    #render :text => params.inspect
  end

  def destroy
    @p = Portlet.where("metric_id = ? AND portal_id = ?", params[:id], params[:portal_id])
    Portlet.destroy @p
    redirect_to :back
    #render :text => params.inspect
  end

  def up
    @portlet = Portlet.find(params[:portlet_id])
    @up = @portlet.display_order - 1
    @portlet.display_order = @up
    @portlet.save
    redirect_to :back
  end

  def down
    @portlet = Portlet.find(params[:portlet_id])
    @up = @portlet.display_order + 1
    @portlet.display_order = @up
    @portlet.save
    redirect_to :back
  end
end
