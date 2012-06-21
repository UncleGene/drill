require 'spec_helper'

describe "Driller App" do
  it "should test in test envirinment" do
   app.settings.environment.should == :test
  end

  it "should show root page" do
    get '/'
    last_response.should be_ok
  end

end
