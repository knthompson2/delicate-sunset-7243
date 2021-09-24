require 'rails_helper'

RSpec.describe 'flights index page' do
  before :each do
    @southwest = Airline.create!(name: "Southwest")
    @frontier = Airline.create!(name: "Frontier")
    @flight_1 = @frontier.flights.create!(number: "1727", date: "10/04/2021", departure_city: "Denver", arrival_city: "Indianapolis")
    @flight_2 = @frontier.flights.create!(number: "1829", date: "10/10/2021", departure_city: "Indianapolis", arrival_city: "Denver")
    @flight_3 = @frontier.flights.create!(number: "1948", date: "2/04/2022", departure_city: "Denver", arrival_city: "Orlando")
    @flight_4 = @southwest.flights.create!(number: "1992", date: "2/11/2022", departure_city: "Orlando", arrival_city: "Denver")
    @bob = Passenger.create!(name: "Bob Smith", age: 47)
    @susie = Passenger.create!(name: "Susie Smith", age: 45)
    @teddy = Passenger.create!(name: "Teddy Behr", age: 17)
    @lauren = Passenger.create!(name: "Lauren Honkomp", age: 23)
    @kevin = Passenger.create!(name: "Kevin Johnson", age: 74)
    FlightPassenger.create!(flight: @flight_1, passenger: @bob)
    FlightPassenger.create!(flight: @flight_2, passenger: @bob)
    FlightPassenger.create!(flight: @flight_1, passenger: @susie)
    FlightPassenger.create!(flight: @flight_2, passenger: @susie)
    FlightPassenger.create!(flight: @flight_1, passenger: @kevin)
    FlightPassenger.create!(flight: @flight_2, passenger: @kevin)
    FlightPassenger.create!(flight: @flight_3, passenger: @susie)
    FlightPassenger.create!(flight: @flight_4, passenger: @susie)
    FlightPassenger.create!(flight: @flight_3, passenger: @teddy)
    FlightPassenger.create!(flight: @flight_4, passenger: @teddy)
    FlightPassenger.create!(flight: @flight_4, passenger: @lauren)

  end

  it 'lists all flight numbers with their airline and all passengers' do
    visit "/flights"

    expect(page).to have_content(@flight_1.number)
    expect(page).to have_content(@flight_2.number)
    expect(page).to have_content(@flight_3.number)
    expect(page).to have_content(@flight_4.number)

    within("#flights-#{@flight_1.id}") do
      expect(page).to have_content(@flight_1.number)
      expect(page).to have_content(@frontier.name)
      expect(page).to have_content(@susie.name)
      expect(page).to have_content(@bob.name)
      expect(page).to have_content(@kevin.name)
    end

  end

  it 'has a button next to each passenger to remove passenger from flight' do
    visit "/flights"

    within("#flights-#{@flight_1.id}") do
      expect(page).to have_content(@susie.name)
      within("#passenger-#{@susie.id}") do
        click_on "Remove Passenger"
      end
      expect(current_path).to eq("/flights")
      expect(page).to_not have_content(@susie.name)
    end
    within("#flights-#{@flight_2.id}") do
      expect(page).to have_content(@susie.name)
    end
  end
end
