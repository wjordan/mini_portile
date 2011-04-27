require "fake_web"
require "fake_web_matcher"

# ensure no real connection is made
FakeWeb.allow_net_connect = false

module Support
  module DownloadHelper
    def self.included(example_group)
      example_group.after :each do
        FakeWeb.clean_registry
      end
    end
  end
end
