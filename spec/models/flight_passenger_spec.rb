require 'rails_helper'

RSpec.describe FlightPassenger do
  describe 'relationships' do
    it { should belong_to(:flight) }
    it { should belong_to(:passenger) }
  end
end
