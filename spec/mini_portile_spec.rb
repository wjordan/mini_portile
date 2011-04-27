require "spec_helper"
require "mini_portile"

describe MiniPortile do
  let(:recipe) { MiniPortile.new("myapp", "1.2.3") }

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
