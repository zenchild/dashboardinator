require 'spec_helper'

describe "Metrics" do
  before do
    @metric = Metric.create :name => "graphite", :description => "generic graphite graph example", :snippet => '<img src="http://dyn.com/wp-content/uploads/Graph.png"/>'
  end

  describe "GET /metrics" do
    it "display some metrics" do
      visit metrics_path
      page.should have_content "graphite"
      page.should have_content "Edit"
      page.should have_content "Delete"
    end

    it "creates a new metric" do
      visit metrics_path
      fill_in 'Name', :with => 'zenoss'
      fill_in 'Description', :with => 'sample Zenoss graph'
      fill_in 'Snippet', :with => '<img src="http://itdzenosst2:8080/zport/RenderServer/render?width=500&gopts=eNqtkE1rAjEQhn9M8ZiPLfQS2MNWowhWipXiQZCYmV1Tsh9N4iolP767IIhVSw89zTvMO_PMDBlHIiMhOzTFLqQJ513SogtGK0us2qJNn00FPo7kWGx75fBzjz4gEKcOKaubwL6wqr1nDbqcjbA1Gj0zASyoJqGdoBXQom5ZAE90XZaqgs3lLOocCPBcZO9ykU3kHRwp1fHfkS_ZKg6veek1Ps6mc5nc2OuBc605z_MftTh5XUznyxsdYpa9LYXeu7UYPNFHmw_8L-bTV4Rqi7_4-zf1Z4kunv3rj2_sEbMj&drange=129600"/>'
      click_button "Create Metric"
      current_path.should == metrics_path
      page.should have_content 'zenoss'
    end
  end

  describe "PUT /metrics" do
    it "edits a metric" do
      visit metrics_path
      click_link "Edit"
      current_path.should == edit_metric_path(@metric)
      find_field("Name").value.should == 'graphite'
      fill_in 'Name', :with => 'new graphite'
      click_button "Update Metric"
      current_path.should == metrics_path
      page.should have_content 'new graphite'

    end

    it "validates the data" do
      visit metrics_path
      click_link "Edit"
      current_path.should == edit_metric_path(@metric)
      find_field("Name").value.should == 'graphite'
      fill_in 'Name', :with => ''
      click_button "Update Metric"
      current_path.should == edit_metric_path(@metric)
      page.should have_content "Validation Error"
    end
  end

  describe "DELETE /metrics" do
    it "deletes a metric" do
      visit metrics_path
      find("#metric_#{@metric.id}").click_link "Delete"
      current_path.should == metrics_path
      page.should have_content "Metric Deleted"
      page.should have_no_content "graphite"
    end
  end
end

describe "Portals" do
  before do
    @metric = Metric.create :name => "graphite", :description => "generic graphite graph example", :snippet => '<img src="http://dyn.com/wp-content/uploads/Graph.png"/>'
    @portal = Portal.create :name => "test portal", :description => "example portal"
    @portlet = Portlet.create :metric_id => @metric.id, :portal_id => @portal.id
  end

  describe "GET /portals" do
    it "display some portals" do
      visit portals_path
      page.should have_content "test portal"
      page.should have_content "Edit"
      page.should have_content "Add/Remove Metrics"
      page.should have_content "Delete"
    end

    it "creates a new portal" do
      visit portals_path
      fill_in 'Name', :with => 'test2'
      fill_in 'Description', :with => 'another test portal'
      click_button "Create Portal"
      current_path.should == portals_path
      page.should have_content 'test2'
    end
  end

  describe "PUT /portals" do
    it "edits a portal metadata" do
      visit portals_path
      click_link "Edit"
      current_path.should == edit_portal_path(@portal)
      find_field("Name").value.should == 'test portal'
      fill_in 'Name', :with => 'new test portal'
      click_button "Update Portal"
      current_path.should == portals_path
      page.should have_content 'new test portal'
    end

    it "validates the data" do
      visit portals_path
      click_link "Edit"
      current_path.should == edit_portal_path(@portal)
      find_field("Name").value.should == 'test portal'
      fill_in 'Name', :with => ''
      click_button "Update Portal"
      current_path.should == edit_portal_path(@portal)
      page.should have_content "Validation Error"
    end
  end

  describe "DELETE /portals" do
    it "deletes a portal" do
      visit portals_path
      find("#portal_#{@portal.id}").click_link "Delete"
      current_path.should == portals_path
      page.should have_content "Portal Deleted"
      page.should have_no_content "test portal"
    end
  end
end

describe "Portlets" do
  before do
    @metric = Metric.create :name => "graphite", :description => "generic graphite graph example", :snippet => '<img src="http://dyn.com/wp-content/uploads/Graph.png"/>'
    @metric2 = Metric.create :name => "zenoss", :description => "generic graphite graph example", :snippet => '<img src="http://dyn.com/wp-content/uploads/Graph.png"/>'
    @portal = Portal.create :name => "test portal", :description => "example portal"
    @portlet = Portlet.create :metric_id => @metric.id, :portal_id => @portal.id
  end

  describe "GET /portal/:id/portlets" do
    it "lists all portlets attached to a specific portal" do
      visit portal_portlets_path(@portal)
      find("metrics_have").should have_content "graphite"
    end

    it "lists the other metrics that are not included" do
      visit portal_portlets_path(@portal)
      page.should have_content "zenoss"
    end

    it "adds new metrics to a portal" do
    end

  end

end
