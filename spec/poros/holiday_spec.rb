require 'rails_helper'

RSpec.describe Holiday do
  it 'exists' do
    data = {name: "Christmas", date: "2021-12-25"}
    holiday = Holiday.new(data)
    expect(holiday).to be_a(Holiday)
    expect(holiday.name).to eq("Christmas")
    expect(holiday.date).to eq("2021-12-25")
  end
end