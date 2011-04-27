require "fake_web"
require "fake_web_matcher"

# ensure no real connection is made
FakeWeb.allow_net_connect = false

module Support
  module DownloadHelper
    FIXTURES_ROOT = File.expand_path("../fixtures", File.dirname(__FILE__))

    def self.included(example_group)
      example_group.after :each do
        FakeWeb.clean_registry
      end
    end

    def fixture_file(filename)
      # build URL for requested file
      url = "http://server.com/pub/%s" % filename

      # read
      file_path = File.join(FIXTURES_ROOT, filename)
      body = File.open(file_path, "rb") { |f| f.read }

      # register download for it
      FakeWeb.register_uri(:get, url, :body => body, :content_length => body.length)

      url
    end
  end
end
