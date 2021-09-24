class Airline < ApplicationRecord
  has_many :flights

  def adult_passengers_by_flight_count
    flights.joins(flight_passengers: :passenger)
           .select("passengers.*, COUNT(flight_passengers.id) AS flight_count")
           .group("passengers.id")
           .where("passengers.age > ?", 17)
           .order("flight_count DESC")
           .distinct

  end
end
