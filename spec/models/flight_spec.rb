require 'rails_helper'

RSpec.describe Flight do
  describe 'relationships' do
    it { should belong_to(:airline) }
    it { should have_many(:flight_passengers) }
    it { should have_many(:passengers).through(:flight_passengers) }
  end
end
