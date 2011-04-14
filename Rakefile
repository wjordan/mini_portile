#
# NOTE: Keep this file clean.
# Add your customizations inside tasks directory.
# Thank You.
#

begin
  require "isolate/now"
rescue LoadError
  abort "This project requires Isolate to manage it's dependencies. Please `gem install isolate` and try again. Thank you."
end

# load individual tasks
Dir['tasks/*.rake'].sort.each { |f| load f }
