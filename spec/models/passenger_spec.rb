require 'rails_helper'

RSpec.describe Passenger do
  describe 'relationships' do
    it { should have_many(:flight_passengers) }
    it { should have_many(:flights).through(:flight_passengers) }
  end
end
