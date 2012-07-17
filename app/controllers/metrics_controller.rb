class MetricsController < ApplicationController
  def index
    @metric = Metric.new
    @out_metrics = Metric.all
  end

  def create
    Metric.create params[:metric]
    redirect_to :back
  end

  def edit
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
