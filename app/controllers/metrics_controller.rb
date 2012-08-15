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

class MetricsController < ApplicationController
  def index
    @purpose = "Create"
    @metric = Metric.new
    @out_metrics = Metric.all
  end

  def create
    Metric.create params[:metric]
    redirect_to :back
  end

  def edit
    @purpose = "Edit"
    @metric = Metric.find params[:id]
  end

  def update
    metric = Metric.find params[:id]
    if metric.update_attributes params[:metric]
      redirect_to metrics_path
    else 
      redirect_to :back, :notice => "Validation Error"
    end
  end

  def destroy
    Metric.destroy params[:id]
    redirect_to :back, :notice => "Metric Deleted"
  end

end
