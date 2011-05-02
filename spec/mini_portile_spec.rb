require "spec_helper"
require "mini_portile"

describe MiniPortile do
  let(:logger) { Support::BlackHole.new }
  let(:recipe) { MiniPortile.new("amhello", "1.0") }
  let(:url) { fixture_file("amhello-1.0.tar.gz") }
  in_temporary_directory

  before :each do
    recipe.logger = logger
    recipe.files << url
  end

  describe "#download" do
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
    before :each do
      recipe.download
    end

    it "extracts files into a temporary location" do
      recipe.extract
      artifacts = Dir.glob("tmp/**/ports/amhello/1.0/*")
      artifacts.should_not be_empty
    end
  end

  describe "#configure" do
    before :each do
      recipe.download
      recipe.extract
    end

    it "succeed in the configure process" do
      recipe.configure.should be_true
    end

    it "generates a log from configure output" do
      recipe.configure
      logs = Dir.glob("tmp/**/ports/amhello/1.0/configure.log")
      logs.should_not be_empty
    end
  end

  describe "#configured?" do
    before :each do
      recipe.download
      recipe.extract
    end

    it "changes after configure process succeed" do
      expect {
        recipe.configure
      }.should change { recipe.configured? }
    end
  end

  describe "#compile" do
    before :each do
      recipe.download
      recipe.extract
      recipe.configure
    end

    it "succeed in the compile process" do
      recipe.compile.should be_true
    end

    it "generates a log from compile output" do
      recipe.compile
      logs = Dir.glob("tmp/**/ports/amhello/1.0/compile.log")
      logs.should_not be_empty
    end
  end
end
