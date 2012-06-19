require 'spec_helper'

describe "Driller App" do

  it "should show root page" do
    get '/'
    last_response.should be_ok
  end

end
