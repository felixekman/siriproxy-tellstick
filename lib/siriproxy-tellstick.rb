require 'cora'
require 'siri_objects'
require 'pp'

class SiriProxy::Plugin::tellstick < SiriProxy::Plugin
  	def initialize(config) end
  	filter "SetRequestOrigin", direction: :from_iphone do |object|
    	puts "[Info - User Location] lat: #{object["properties"]["latitude"]}, long: #{object["properties"]["longitude"]}"
  	end 

    listen_for /test tellstick/i do
      say "Tellstick Siri is up and running!" #say something to the user!

      request_completed #always complete your request! Otherwise the phone will "spin" at the user!
    end


#################Bedroom############################################
####Se tellstick.conf, för hur man ställer in olika id###
  	listen_for /off.*bedroom/i do
    	say "Turning off bedroom lights..." 
    	system "/usr/bin/tdtool --off 1"
    	request_completed 
  	end

  	listen_for /on.*bedroom/i do
    	say "Turning on bedroom lights..." 
    	system "/usr/bin/tdtool --on 1"
    	request_completed 
  	end

###Dimmings commando säg nått värde mellan 0-255#####  	
  	listen_for /dim.*bedroom to ([0-9,]*[0-9]*[0-9])/i do
    	say "Dimming bedroom lights..." 
    	system "/usr/bin/tdtool --dimlevel #{number} --dim 1"
    	request_completed 
  	end
  	
  	
    	listen_for /goodnight/i do
  		    	system "/usr/bin/tdtool --off 1"
  		    	system "/usr/bin/tdtool --off 2"
  	       	system "/usr/bin/tdtool --off 3"
  		    	system "/usr/bin/tdtool --off 4"
  		    	system "/usr/bin/tdtool --off 5"
  	       	system "/usr/bin/tdtool --off 6"
  		    	system "/usr/bin/tdtool --off 7"
  		    	system "/usr/bin/tdtool --off 8"
  	       	system "/usr/bin/tdtool --off 9"
  	       	say "Goodnight Sir! Sleep well." 
  	   		request_completed 
  		end



###EXPERIMENT-Säg stäng av så frågar siri om stänga av allt eller specifikt rum#####  	

    	listen_for /turn off/i do
     	response = ask "Everything or specific room?"
  	if(response =~ /Everything/i) 
        		say "Turning off everything..." 
  		    	system "/usr/bin/tdtool --off 1"
  		    	system "/usr/bin/tdtool --off 2"
  	       	system "/usr/bin/tdtool --off 3"
  		    	system "/usr/bin/tdtool --off 4"
  		    	system "/usr/bin/tdtool --off 5"
  	       	system "/usr/bin/tdtool --off 6"
  		    	system "/usr/bin/tdtool --off 7"
  		    	system "/usr/bin/tdtool --off 8"
  	       	system "/usr/bin/tdtool --off 9"
  	    	else
  		if(response =~ /Specific Room/i)
  		response = ask "Which room?"
  	if(response =~ /Bedroom/i)
  		say "Turning off bedroom..." 
    	system "/usr/bin/tdtool --off 1"
  	if(response =~ /Living room/i)   
  		say "Turning off Living room..." 
    	system "/usr/bin/tdtool --off 2" 		
  	else say "Sorry, I didn't get that."  		
  		end
  	end
      	request_completed
    	end










  	
######EXPERIMENT-demonstrate the different sensors.
    listen_for /show sensors/i do
      add_views = SiriAddViews.new
      add_views.make_root(last_ref_id)
      map_snippet = SiriMapItemSnippet.new
      map_snippet.items << SiriMapItem.new
      utterance = SiriAssistantUtteranceView.new("Testing map injection!")
      add_views.views << utterance
      add_views.views << map_snippet

      #you can also do "send_object object, target: :guzzoni" in order to send an object to guzzoni
      send_object add_views #send_object takes a hash or a SiriObject object

      request_completed #always complete your request! Otherwise the phone will "spin" at the user!
    end

end