require 'rails_helper'

RSpec.describe 'airline show page' do
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
    FlightPassenger.create!(flight: @flight_3, passenger: @susie)
    FlightPassenger.create!(flight: @flight_4, passenger: @susie)
    FlightPassenger.create!(flight: @flight_3, passenger: @teddy)
    FlightPassenger.create!(flight: @flight_4, passenger: @teddy)
    FlightPassenger.create!(flight: @flight_4, passenger: @lauren)
  end

  it 'lists all names of adult passengers for all flights on airline' do
    visit "/airlines/#{@frontier.id}"
    save_and_open_page
    expect(page).to have_content(@bob.name)
    expect(page).to have_content(@susie.name)
    expect(page).to have_content(@kevin.name)
    expect(@susie.name).to appear_before(@bob.name)
    expect(@bob.name).to appear_before(@kevin.name)
    #teddy is not an adult
    expect(page).to_not have_content(@teddy.name)
    #lauren is only a passenger on southwest
    expect(page).to_not have_content(@lauren.name)

  end
end
