require 'watir' # Crawler
require 'pry' # Ruby REPL
require 'rb-readline' # Ruby IRB
require 'awesome_print' # Console output
require_relative 'credentials' # Grab login credentials

username = $username
password = $password
like_counter = 0
MAX_LIKES = 250

# Open chrome to login page
browser = Watir::Browser.new :chrome, switches: ['--incognito']
browser.goto "instagram.com/accounts/login/"

# Enter login credentials
puts "Logging in..."
browser.text_field(:name => "username").set "#{username}"
browser.text_field(:name => "password").set "#{password}"

# Click Login Button
browser.button(:class => '_5f5mN       jIbKX KUBKM      yZn4P   ').click
sleep(2)
puts "Log in successful"

# Loop through explore page
loop do
  browser.goto "instagram.com/explore/"

  sleep(2)

  if like_counter >= MAX_LIKES
    sleep(21600)
    like_counter = 0
    ap "Like Counter Reset"
  end

  # Call all unliked like buttons on page and click each one.
  if browser.div(:class => "_9AhH0").exists?
    ap "FOUND DIV"
    browser.div(:class => "_9AhH0").click
    sleep(2.5)
    10.times do
	
        if browser.button(:class => "coreSpriteHeartOpen oF4XW dCJp8").exists?
            ap "LIKE FOUND"
            browser.button(:class => "coreSpriteHeartOpen oF4XW dCJp8").click

            like_counter += 1
            ap "Photos liked: #{like_counter}"
            sleep(2.5)

				if browser.a(:class => "HBoOv coreSpriteRightPaginationArrow").exists?
					ap "NEXT FOUND"
					browser.a(:class => "HBoOv coreSpriteRightPaginationArrow").click
					sleep(2.5)
				else
					ap "NEXT NOT FOUND"
				end
			
        else
            ap "LIKE NOT FOUND"
        end
		
    end
	
  else
    ap "Nothing found..."
  end
  
  if like_counter >= MAX_LIKES
    sleep(21600)
    like_counter = 0
  end
  
  sleep(2.5)
end

# Leave this in to use the REPL at end of program
# Otherwise, take it out and program will just end
# Pry.start(binding)
