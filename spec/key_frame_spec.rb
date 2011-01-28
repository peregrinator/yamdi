require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "KeyFrame" do
  let(:flv_path) { File.join(File.dirname(__FILE__), 'files', 'sample.flv') }
  
  before(:all) do
    @metadata_xml = Yamdi.new(flv_path).metadata
  end
  
  context "internal class methods" do
    it "#self.get_times returns an array of times" do
      times = KeyFrame.get_times(@metadata_xml.xpath("//keyframes/times/value"))
      times.first.should eq(0.04)
      times.last.should eq(6.04)
    end
  
    it "#self.get_file_positions returns an array of file positions" do
     file_positions = KeyFrame.get_file_positions(@metadata_xml.xpath("//keyframes/filepositions/value"))
     file_positions.first.should eq(1327)
     file_positions.last.should eq(83017)
    end
  end
  
  it "#self.all_from_xml returns an array of Key Frame objects" do
    KeyFrame.all_from_xml(@metadata_xml.xpath("//keyframes")).class.should eq(Array)
  end
  
  before(:all) do
    @key_frames = KeyFrame.all_from_xml(@metadata_xml.xpath("//keyframes"))
  end

  it "#time returns the proper time value" do
    @key_frames.first.time.should eq(0.04)
    @key_frames.last.time.should eq(6.04)
  end
  
  it "#file_position returns the proper file position value" do
    @key_frames.first.file_position.should eq(1327)
    @key_frames.last.file_position.should eq(83017)
  end
end