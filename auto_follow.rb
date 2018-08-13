require 'watir' # Crawler
require 'pry' # Ruby REPL
require 'rb-readline' # Ruby IRB
require 'awesome_print' # Console output
require_relative 'credentials' # Grab login credentials

username = $username
password = $password
users = ['instagram', 'selenagomez', 'arianagrande', 'taylorswift', 'beyonce', 'kimkardashian', 'cristiano', 'kyliejenner', 'justinbieber', 'kendalljenner', 'nickiminaj', 'natgeo', 'neymarjr', 'nike', 'leomessi','khloekardashian', 'mileycyrus', 'katyperry', 'jlo', 'ddlovato', 'kourtneykardash', 'victoriasecret', 'badgalriri', 'fcbarcelona', 'realmadrid', 'theellenshow', 'justintimberlake', 'zendaya' 'caradelevingne', '9gag', 'chrisbrownofficial', 'vindiesel', 'champagnepapi', 'davidbeckham', 'shakira', 'gigihadid', 'emmawatson', 'jamesrodiguez10', 'kingjames', 'garethbale11', 'nikefootball', 'adele', 'zacefron', 'vanessahudgens', 'ladygaga', 'maluma', 'nba', 'nasa', 'rondaldinho', 'luissuarez9', 'zayn', 'shawnmendes', 'adidasfootball', 'brumarquezine', 'hm', 'harrystyles','chanelofficial', 'ayutingting92', 'letthelordbewithyou', 'niallhoran', 'anitta', 'hudabeauty', 'camerondallas', 'adidasoriginals', 'marinaruybarbosa', 'lucyhale', 'karimbenzema', 'princessyahrini', 'zara', 'nickyjampr', 'onedirection', 'andresiniesta8', 'raffinagita1717', 'krisjenner', 'manchesterunited', 'natgeotravel', 'marcelottwelve', 'deepikapadukone', 'snoopdogg', 'davidluiz_4', 'kalbiminrozeti', 'priyankachopra', 'ashleybenson', 'shaym', 'lelepons', 'prillylatuconsina96','louisvuitton','britneyspears', 'sr4official', 'jbalvin', 'laudyacynthiabella', 'ciara', 'stephencurry30', 'instagrambrasil']
follow_counter = 0
unfollow_counter = 0
MAX_UNFOLLOWS = 200
start_time = Time.now

# Open chrome to login page
browser = Watir::Browser.new :chrome, switches: ['--incognito']
browser.goto "instagram.com/accounts/login/"

# Enter login credentials
puts "Logging in..."
browser.text_field(:name => "username").set "#{username}"
browser.text_field(:name => "password").set "#{password}"

# Click Login Button
browser.button(:class => '_5f5mN jIbKX KUBKM yZn4P').click
sleep(2)
puts "Log in successful"

# Loop through defined user array
loop do
  users.each { |val|
    # Navigate to user's page
    browser.goto "instagram.com/#{val}/"

    # If not following then follow
    if browser.button(:class => '_5f5mN jIbKX _6VtSN yZn4P').exists?
      ap "Following #{val}"
      browser.button(:class => '_5f5mN jIbKX _6VtSN yZn4P').click
      sleep(1)
      follow_counter += 1
      sleep(1)
    elsif browser.button(:class => '_5f5mN -fzfL _6VtSN yZn4P').exists?
      ap "Unfollowing #{val}"
      browser.button(:class => '_5f5mN -fzfL _6VtSN yZn4P').click
      sleep(1)
      browser.button(:class => 'aOOlW -Cab_ ').click
      unfollow_counter += 1
      sleep(1)
    end
    sleep(1.0/2.0) # Sleep to allow load time
  }
  puts "--------- #{Time.now} ----------"
  break if unfollow_counter >= MAX_UNFOLLOWS
  sleep(30) # Sleep 1 hour
end

ap "Followed #{follow_counter} users and unfollowed #{unfollow_counter} in #{((Time.now - start_time)/60).round(2)} minutes"

# Leave this in to use the REPL at end of program
# Otherwise, take it out and program will just end
Pry.start(binding)