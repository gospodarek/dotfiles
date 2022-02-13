# method for requiring additional gems including within bundle

if defined?(Hirb)
  Hirb.enable
end

# A time block for seeing how long things take to complete  E.g.  time { 100000.times {|i| i**2} }  # => 0.05 secs
def time; b = Time.now; yield; "Time to complete: #{Time.now-b} secs"; end

IRB.conf[:AUTO_INDENT]=true

# I don't know what this is or where it came from anymore
script_console_running = (ENV.include?('RAILS_ENV') and IRB.conf[:LOAD_MODULES].include?('console_with_helpers'))
rails_running = (ENV.include?('RAILS_ENV') and !IRB.conf[:LOAD_MODULES].include?('console_with_helpers'))
irb_standalone_running = (!script_console_running and !rails_running)

# This allows me to turn off the irb echo-ing crap.  E.g. IRB.echo_off and IRB.echo_on
module IRB

  def self.echo_on
     conf.echo = true
     Hirb.enable if defined?(Hirb)
  end

  def self.echo_off
     conf.echo = false
     Hirb.disable if defined?(Hirb)
  end
  
end 


