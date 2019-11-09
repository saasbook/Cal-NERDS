require 'rails_helper'
RSpec.describe "convert date_time" do
  
  it 'returns empty' do
    ans1 = {"mon_times" => "", 
          "tue_times" => "", 
          "wed_times" => "",
          "thu_times" => "",
          "fri_times" => ""}
    expect(Schedule.group_weekday([])).to eq(ans1)
  end
  
  it "returns 24hr times" do
    arr1 = [["M", "12:00 AM"]]
    ans1 = {'mon_times' => "0000",
          "tue_times" => "", 
          "wed_times" => "",
          "thu_times" => "",
          "fri_times" => ""}
    expect(Schedule.group_weekday(arr1)).to eq(ans1)
    
    arr2 = [["M", "01:00 AM"]]
    ans2 = {'mon_times' => "0100",
          "tue_times" => "", 
          "wed_times" => "",
          "thu_times" => "",
          "fri_times" => ""}
    expect(Schedule.group_weekday(arr2)).to eq(ans2)
    
    arr3 = [["M", "12:00 PM"]]
    ans3 = {'mon_times' => "1200",
          "tue_times" => "", 
          "wed_times" => "",
          "thu_times" => "",
          "fri_times" => ""}
    expect(Schedule.group_weekday(arr3)).to eq(ans3)
    
    arr4 = [["M", "11:00 PM"]]
    ans4 = {'mon_times' => "2300",
          "tue_times" => "", 
          "wed_times" => "",
          "thu_times" => "",
          "fri_times" => ""}
    expect(Schedule.group_weekday(arr4)).to eq(ans4)
  end
  
  it "concatenates times" do
    arr1 = [["M", "11:00 AM"], 
            ["M", "12:30 PM"],
            ["M", "01:00 PM"]]
    ans1 = {'mon_times' => "1100 1230 1300",
          "tue_times" => "", 
          "wed_times" => "",
          "thu_times" => "",
          "fri_times" => ""}
    expect(Schedule.group_weekday(arr1)).to eq(ans1)
  end
  
  it "parses multiple dates" do
    arr1 = [["M", "07:00 AM"], 
            ["T", "07:00 AM"], 
            ["W", "07:00 AM"],
            ["R", "07:00 AM"],
            ["F", "07:00 AM"]]
    ans1 = {'mon_times' => "0700",
          "tue_times" => "0700", 
          "wed_times" => "0700",
          "thu_times" => "0700",
          "fri_times" => "0700"}
    expect(Schedule.group_weekday(arr1)).to eq(ans1)
  end
  
  it "only takes 30 min intervals" do
    #TODO
  end
  
  it "group_weekday works?" do
    eg = [["M", "11:00 AM"], 
          ["M", "12:30 PM"],
          ["T", "12:30 AM"],
          ["F", "01:00 PM"]]
    ans = {"mon_times" => "1100 1230", 
          "tue_times" => "0030", 
          "wed_times" => "",
          "thu_times" => "",
          "fri_times" => "1300"}
    expect(Schedule.group_weekday(eg)).to eq(ans)
  end
end
