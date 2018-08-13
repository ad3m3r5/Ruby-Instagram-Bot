require 'watir' # Crawler
require 'pry' # Ruby REPL
require 'rb-readline' # Ruby IRB
require 'awesome_print' # Console output
require_relative 'credentials' # Grab login credentials

username = $username
password = $password
like_counter = 0
num_of_rounds = 0
MAX_LIKES = 1500

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

# Loop until max likes
loop do
  # Scroll to bottom 3x to load posts
  3.times do |i|
    browser.driver.execute_script("window.scrollBy(0,document.body.scrollHeight)")
    sleep(1)
  end

  # Like all un-liked posts
  if browser.span(:class => "glyphsSpriteHeart__outline__24__grey_9 u-__7").exists?
    browser.spans(:class => "glyphsSpriteHeart__outline__24__grey_9 u-__7").each { |val|
        val.click
        like_counter += 1
    }
    ap "Photos liked: #{like_counter}"
  else
    ap "Nothing found..."
  end
  num_of_rounds += 1
  puts "--------- #{like_counter / num_of_rounds} likes per round (on average) ----------"
  break if like_counter >= MAX_LIKES
  sleep(30) # Return to top of loop after this many seconds to check for new photos
end

# Leave this in to use the REPL at end of program
# Otherwise, take it out and program will just end
Pry.start(binding)