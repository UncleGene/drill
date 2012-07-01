require 'spec_helper'

describe "Driller App" do
  it "should test in test envirinment" do
   app.settings.environment.should == :test
  end

  describe "unknown student" do
    it "should show forbidden" do
      get "/something"
      last_response.status.should == 403
    end
  end

  describe "workout" do
    before do
      @s = Student.create(:login_name => example.description.gsub(/\s+/, ''))
      10.times{|i| @s.add "exercise #{i}"}
    end
    
    context "when show" do
      it "should show exercise" do
        get "/#{@s.login_name}"
        last_response.should be_ok
        last_response.body.should match /exercise/
      end

      it "should show same exercise" do
        get "/#{@s.login_name}"
        body = last_response.body
        get "/#{@s.login_name}"
        last_response.body
        last_response.body.should == body
      end
    end

    context 'when done' do
      it "should advance" do
        e = @s.on_plate
        e.count.should == 0
        @s.score.should == 0
        Record.stub(:done)
        post "/#{@s.login_name}"
        @s.reload.score.should == 1
        e.reload.count.should == 1
      end
      
      it "should randomize exercises" do
        Record.stub(:done)
        5.times.map {
          post "/#{@s.login_name}"
          last_response.body.match(/exercise (\d)/)[1]
        }.uniq.size.should be > 1
      end
    end

    context "when adds" do
      it "should add new exercise" do
        post "/#{@s.login_name}/list", {:title => "New exercise"}
        last_response.should be_ok
        @s.reload.exercises.size.should == 11
      end

      it "should handle short title" do
        post "/#{@s.login_name}/list", {:title => " a    "}
        last_response.should be_ok
        @s.reload.exercises.size.should == 10
      end

    end
  end
end
