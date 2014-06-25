require 'httparty'
require 'json'

class SiriProxy::Plugin::Macintosh < SiriProxy::Plugin
  attr_accessor :host
  
  def initialize(config = {})
  
  end

#### ENGLISH SPEAKING REQUIRED, BUT YOU CAN CHANGE IT AS WELL ####

#mac control
  listen_for(/mac.*restart/i) { set_mac_restart }
  listen_for(/restart.*mac/i) { set_mac_restart }
  listen_for(/logout.*mac/i) { set_mac_logout }
  listen_for(/mac.*logout/i) { set_mac_logout }
  listen_for(/sleep.*macintosh/i) { set_mac_sleep }
  listen_for(/mac.*sleep/i) { set_mac_sleep }
 

#iTunes control
 listen_for(/stop.*itunes/i) { kill_iTunes }
  listen_for(/itunes.*stop/i) { kill_iTunes }
  listen_for(/mac.*next/i) { itunes_next }
   listen_for(/mac.*previous/i) { itunes_prev }
   listen_for(/mac.*pause/i) { itunes_pause }
    listen_for(/mac.*play/i) { itunes_play }

#battery
listen_for(/mac.*battery/i) { set_battery_status }
  
  #Macintosh
 
	def set_mac_sleep
	say "Mac will sleep now"

	system("/usr/bin/osascript -e 'tell application \"System Events\" to sleep'");
	end

	def set_mac_restart
	say "Restarting Mac"

	system("/usr/bin/osascript -e 'tell application \"System Events\" to sleep'");
	end
	
	def set_mac_logout
	say "Logging out"
	
	system("osascript -e 'tell application \"System Events\" to log out'");
	end

##### ITUNES CONTROL ###

	def kill_iTunes
	say "Closing iTunes"
	
	system("osascript -e 'tell application \"iTunes\" to quit'");
	end


    def play_random_song
    
    end
    def itunes_next
    
    system("osascript -e 'tell application \"iTunes\" to next track'");

    end
    def itunes_prev
    
    system("osascript -e 'tell application \"iTunes\" to previous track'");
    
    end
    def itunes_pause
    
    system("osascript -e 'tell application \"iTunes\" to pause'");
    
    end
    def itunes_play
    
    system("osascript -e 'tell application \"iTunes\" to play'");
    
    end
    



def get_file_as_string(filename)
  data = ''
  f = File.open(filename, "r") 
  f.each_line do |line|
    data += line
  end
  return data
end

def set_battery_status 


## BATTERY ##
 system("ioreg -l | grep Capacity > ~/Desktop/user.txt");

fileBattery = get_file_as_string '~/Desktop/test.txt'  ## CHANGE 'nimesh' BY THE USERNAME YOU ARE LOGGED IN ON YOUR MAC
fileBattery2MAX = fileBattery.scan(/\d+/)[0]
fileBattery2Current = fileBattery.scan(/\d+/)[1]

p1 = fileBattery2Current.to_i
p2 = fileBattery2MAX.to_i
pourcentageBATTERY = (p1.to_f / p2.to_f) * 100

say "#{pourcentageBATTERY} percent battery is left on Mac."

###

### POWERED ###

system("ioreg -w0 -l | grep \"ExternalConnected\" > ~/Desktop/user.txt");

filePowered = get_file_as_string '~/Desktop/user.txt'  ## CHANGE 'nimesh' BY THE USERNAME YOU ARE LOGGED IN ON YOUR MAC

if filePowered.include? "No"
say "Votre Mac n'est pas branche au secteur"
if(pourcentageBATTERY < 21.000000000)

say "Vous devriez brancher votre ordinateur, il reste moins de 20% de batterie."
end
else
say "Votre Mac est en train de recharger"


end

###

end  

  
end
