require "spec_helper"
require "mini_portile"

describe MiniPortile do
  let(:logger) { Support::BlackHole.new }
  let(:recipe) { MiniPortile.new("amhello", "1.0") }
  let(:url) { fixture_file("amhello-1.0.tar.gz") }

  before :each do
    recipe.logger = logger
    recipe.files << url
  end

  describe "#download" do
    in_temporary_directory

    it "downloads the indicated file" do
      recipe.download
      FakeWeb.should have_requested(:get, url)
    end

    it "places the downladed file in archives directory" do
      recipe.download
      archives = Dir.glob("ports/archives/*.*")
      archives.should include("ports/archives/amhello-1.0.tar.gz")
    end
  end

  describe "#extract" do
    in_temporary_directory

    before :each do
      recipe.download
    end

    it "extracts files into a temporary location" do
      recipe.extract
      artifacts = Dir.glob("tmp/**/ports/amhello/1.0/*")
      artifacts.should_not be_empty
    end
  end
end
