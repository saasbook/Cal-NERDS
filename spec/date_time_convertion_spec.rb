require 'rails_helper'
RSpec.describe "convert date_time" do
  it "group_weekday works?" do
    eg = [["M", "11:00 AM"], ["M", "12:30 PM"], ["T", "12:30 AM"], ["F", "01:00 PM"]]
    ans = {"mon_times" => "1100 1230", "tue_times" => "0030", "wed_times" => "","thu_times" => "","fri_times" => "1300"}
    expect(Schedule.group_weekday(eg)).to eq(ans)
  end
end
