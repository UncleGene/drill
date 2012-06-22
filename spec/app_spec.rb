require 'spec_helper'

describe "Driller App" do
  it "should test in test envirinment" do
   app.settings.environment.should == :test
  end

  context "/" do
    it "should show root page" do
      get '/'
      last_response.should be_ok
    end
    
    it "should show student" do
      s = Student.create
      s.update(:score => 12)
      get '/', {}, 'rack.session' => {:uid => s.id}
      last_response.should be_ok
      last_response.body.should match /12/
      last_response.body.should match /Nothing/ 
    end

    it "should show exercise" do
      s = Student.create
      s.exercises << Exercise.new(:name => 'Ex1')
      s.save
      get '/', {}, 'rack.session' => {:uid => s.id}
      last_response.should be_ok
      last_response.body.should match /Ex1/
    end

    it "should show same exercise" do
      s = Student.create
      s.exercises = 10.times.map{|i| Exercise.new(:name => "ex#{i}")}
      s.save
      get '/', {}, 'rack.session' => {:uid => s.id}
      body = last_response.body
      get '/', {}, 'rack.session' => {:uid => s.id}
      last_response.body
      last_response.body.should == body
    end
  end

  context '/done' do
    it "should advance" do
      s = Student.create
      s.exercises = 10.times.map{|i| Exercise.new(:name => "ex#{i}")}
      s.save
      e = s.on_plate
      s.start
      Record.any_instance.stub(:started_at) {Time.now - 200}
      post '/done', {}, 'rack.session' => {:uid => s.id}
      s.reload.score.should == 1
      e.reload.count.should == 1
    end
    
    it "should randomize exercises" do
      s = Student.create
      s.exercises = 10.times.map{|i| Exercise.new(:name => "ex#{i}")}
      s.save
      s.start
      Record.stub(:done)
      5.times.map {
        post '/done', {}, 'rack.session' => {:uid => s.id}
        last_response.body.match(/ex(\d)/)[1]
      }.uniq.size.should be > 1
    end
  end
end
