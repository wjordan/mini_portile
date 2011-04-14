begin
  require "isolate/now"
rescue LoadError
  abort "This project requires Isolate to manage it's dependencies. Please `gem install isolate` and try again. Thank you."
end

RSpec.configure do |config|
end
