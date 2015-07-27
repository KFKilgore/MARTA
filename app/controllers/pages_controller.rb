class PagesController < ApplicationController
  include ApplicationHelper
  def home
  end

  def yourBuses
    # the passed parameter is set to an instance variable
    @station = params[:station]
    # here we pull the real-time info from MARTA and put it in a has called @results
    @results = JSON.parse(open("http://developer.itsmarta.com/BRDRestService/BRDRestService.svc/GetAllBus").read)
    #use an application helper to set the hash to only those buses heading toward the selected station
    hash_and_msg_generator(@results, @station)
  end
  
end
