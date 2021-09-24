class FlightPassengersController < ApplicationController
  def destroy
    flight_passenger= FlightPassenger.find_by(flight: params[:flight_id], passenger: params[:passenger_id])
    flight_passenger.destroy
    redirect_to '/flights'
  end
end
