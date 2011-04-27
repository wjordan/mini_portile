require "spec_helper"
require "mini_portile"

describe MiniPortile do
  let(:logger) { Support::BlackHole.new }

  describe "#new" do
    it "accepts additional options during initialization" do
      recipe = MiniPortile.new("myapp", "1.2.3", :logger => logger)
      recipe.logger.should eql(logger)
    end
  end

  describe "#download" do
    let(:recipe) { MiniPortile.new("amhello", "1.0", :logger => logger) }
    let(:url) { fixture_file("amhello-1.0.tar.gz") }
    in_temporary_directory

    before :each do
      recipe.files << url
    end

    it "downloads the indicated files" do
      recipe.download
      FakeWeb.should have_requested(:get, url)
    end
  end
end
