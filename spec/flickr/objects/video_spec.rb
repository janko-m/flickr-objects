require "spec_helper"
require "uri"

VIDEO_ATTRIBUTES = {
  ready?:              proc { be_a_boolean },
  failed?:             proc { be_a_boolean },
  pending?:            proc { be_a_boolean },

  duration:            proc { be_a(Integer) },
  width:               proc { be_a(Integer) },
  height:              proc { be_a(Integer) },

  source_url:          proc { be_a_nonempty(String) },
  download_url:        proc { be_a_nonempty(String) },
  mobile_download_url: proc { be_a_nonempty(String) },
}

describe Flickr::Video do
  describe "methods" do
    context "flickr.photos.search" do
      before(:all) { @it = Flickr.media.search(user_id: USER_ID, extras: EXTRAS).find(VIDEO_ID) }
      subject { @it }

      it "has thumbnail methods" do
        @it.thumbnail_url("Square 75").should match URI.regexp
        @it.thumbnail_url("Square 75").should_not eq @it.thumbnail_url("Thumbnail")

        @it.thumbnail_width("Square 75").should eq 75
        @it.thumbnail_height("Square 75").should eq 75
      end
    end
  end

  describe "attributes" do
    context "flickr.photos.getInfo" do
      before(:all) { @it = Flickr.videos.find(VIDEO_ID).get_info! }
      subject { @it }

      test_attributes(VIDEO_ATTRIBUTES.except(:source_url, :download_url, :mobile_download_url))
    end

    context "flickr.photos.getSizes" do
      before(:all) { @it = Flickr.videos.find(VIDEO_ID).get_sizes! }
      subject { @it }

      test_attributes(VIDEO_ATTRIBUTES.only(:source_url, :download_url, :mobile_download_url))

      it "has sizes" do
        @it.thumbnail_url("Square 75").should match URI.regexp
        @it.thumbnail_width("Square 75").should eq 75
        @it.thumbnail_height("Square 75").should eq 75
      end
    end
  end
end