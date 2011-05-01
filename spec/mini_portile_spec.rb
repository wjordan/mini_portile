require "spec_helper"
require "mini_portile"

describe MiniPortile do
  let(:logger) { Support::BlackHole.new }

  describe "#download" do
    let(:recipe) { MiniPortile.new("amhello", "1.0") }
    let(:url) { fixture_file("amhello-1.0.tar.gz") }
    in_temporary_directory

    before :each do
      recipe.logger = logger
      recipe.files << url
    end

    it "download the indicated file" do
      recipe.download
      FakeWeb.should have_requested(:get, url)
    end

    it "place the downladed file in archives directory" do
      recipe.download
      archives = Dir.glob("ports/archives/*.*")
      archives.should include("ports/archives/amhello-1.0.tar.gz")
    end
  end
end
