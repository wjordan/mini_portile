require "spec_helper"
require "mini_portile"

describe MiniPortile do
  let(:recipe) { MiniPortile.new("myapp", "1.2.3") }

  describe "#new" do
    it "accepts additional options during initialization" do
      logger = Support::BlackHole.new
      recipe = MiniPortile.new("myapp", "1.2.3", :logger => logger)
      recipe.logger.should eql(logger)
    end
  end

  describe "#download" do
    let(:url) { "http://myserver.com/myapp-1.2.3.tar.gz" }
    in_temporary_directory

    before :each do
      recipe.files << url

      FakeWeb.register_uri(:get, url, :body => "FIXME", :content_length => 5)
    end

    it "downloads the files indicated" do
      recipe.download
      FakeWeb.should have_requested(:get, url)
    end
  end
end
