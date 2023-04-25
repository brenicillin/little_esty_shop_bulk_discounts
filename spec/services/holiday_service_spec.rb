require 'rails_helper'

RSpec.describe 'Holiday Service' do
  describe 'class methods' do
    it 'returns holidays' do
      holidays = HolidayService.holidays
      holiday1 = holidays.first
      require 'pry'; binding.pry
      expect(holidays).to be_an(Array)
      expect(holidays.count).to eq(3)

      expect(holiday1).to have_key(:name)
      expect(holiday1[:name]).to be_a(String)
      expect(holiday1).to have_key(:date)
      expect(holiday1[:date]).to be_a(String)
    end
  end
end