require 'spec_helper'

describe Weeklytimetable do
  
  before { @weeklytimetable = FactoryGirl.create(:weeklytimetable) }
  #have to create 1 set of matching 'weeklytimetable' with 2 timetable - not ok
  #before { @weeklytimetable = FactoryGirl.create(:weeklytimetable, format1: 1, format2: 2) }
  
  subject { @weeklytimetable }
  
  it { should respond_to(:programme_id) }
  it { should respond_to(:intake_id) }
  it { should respond_to(:startdate) }
  it { should respond_to(:enddate) }
  it { should respond_to(:semester) }
  it { should respond_to(:prepared_by) }
  it { should respond_to(:endorsed_by) }
  it { should respond_to(:format1) }
  it { should respond_to(:format2) }
  it { should respond_to(:week) }
  it { should respond_to(:is_submitted) }
  it { should respond_to(:submitted_on) }
  it { should respond_to(:hod_approved) }
  it { should respond_to(:hod_approved_on) }
  it { should respond_to(:hod_rejected) }
  it { should respond_to(:hod_rejected_on) }
  it { should respond_to(:reason) }
  
  it { should be_valid }    
  
  #validates_presence_of :programme_id, :semester, :intake_id, :format1, :format2;
  
   describe "when programme_id is not present" do
    before { @weeklytimetable.programme_id = nil }
    it { should_not be_valid }
  end
  
  describe "when format1 is not present" do
    before {@weeklytimetable.format1 = nil }
    it { should_not be_valid }
  end
  
  describe "when format2 is not present" do
    before {@weeklytimetable.format2 = nil }
    it { should_not be_valid }
  end

end