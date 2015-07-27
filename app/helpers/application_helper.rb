module ApplicationHelper
  
  #this is where the User's selection 'station' will be compared with the API data 'results'.
  def hash_and_msg_generator(results, station)
    
    #we'll have messages to tell the user whether a bus is coming soon or not.
    @message = ""
    
    #we want to provide the user with the route and vehicle numbers for the approaching bus(es).
    # The best way to save 2 related items is a hash!
    
    @buses = {}
    
    results.each do |result|
      if result["TIMEPOINT"].include? station
        #if the user's selection matches an oncoming bus stop in the API data
        #we will save that info in our hash:
        @buses[result["ROUTE"]] = result["VEHICLE"]
        #the Route is the key and Vehicle is the value
      end
end
    #display message to user letting them know if a bus is on their way
    if @buses.count == 0
      #no buses have the user's station as their next stop
      @message = "Sorry, it's going to be a while."
    elsif @buses.count == 1
      #One bus will be making the user's station its next stop
      @message = "A bus is on its way!"
    elsif @buses.count > 1
      #more than one bus will stop at the user's station
      @message = "These buses will be coming soon:"
    else 
      #just in case we end up with a negative number somehow...
      @message = "Oops. We seem to have a slight error."
    end
    #end of hash_and_msg_generator(results, station).
  end
  
end