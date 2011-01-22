require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Yamdi" do
  it "expects the yamdi command line tool to be installed" do
    system `which yamdi`
    $?.exitstatus.should eq(1)
  end
  
  let(:flv_path) { File.join(File.dirname(__FILE__), 'files', 'sample.flv') }
  
  before(:all) do
    @yamdi = Yamdi.new(flv_path)
  end
  
  it "#duration returns the duration of the flv file" do
    @yamdi.duration.should eq(6.06)
  end
  
  it "#has_keyframes? returns hasKeyframes" do
    @yamdi.has_keyframes?.should eq(true)
  end
  
  it "#has_video? returns hasVideo" do
    @yamdi.has_video?.should eq(true)
  end
  
  it "#has_audio? returns hasAudio" do
    @yamdi.has_audio?.should eq(true)
  end
  
  it "#has_metadata? returns hasMetadata" do
    @yamdi.has_metadata?.should eq(true)
  end
  
  it "#has_cue_points? returns hasCuePoints" do
    @yamdi.has_cue_points?.should eq(false)
  end
  
  it "#can_seek_to_end? returns canSeekToEnd" do
    @yamdi.can_seek_to_end?.should eq(true)
  end
  
  it "#audio_codec_id returns audiocodecid" do
    @yamdi.audio_codec_id.should eq(2)
  end
  
  it "#audio_sample_rate returns audiosamplerate" do
    @yamdi.audio_sample_rate.should eq(3)
  end
  
  it "#audio_data_rate returns audiodatarate" do
    @yamdi.audio_data_rate.should eq(94)
  end
  
  it "#audio_sample_size returns audiosamplesize" do
    @yamdi.audio_sample_size.should eq(1)
  end
  
  it "#audio_delay returns audiodelay" do
    @yamdi.audio_delay.should eq(0.00)
  end
  
  it "#stereo? returns stereo" do
    @yamdi.stereo?.should eq(true)
  end
  
  it "#video_codec_id returns videocodecid" do
    @yamdi.video_codec_id.should eq(4)
  end
  
  it "#frame_rate returns framerate" do
    @yamdi.frame_rate.should eq(0.33)
  end
  
  it "#video_data_rate returns videodatarate" do
    @yamdi.video_data_rate.should eq(14)
  end
  
  it "#height returns height" do
    @yamdi.height.should eq(288)
  end
  
  it "#width returns height" do
    @yamdi.width.should eq(360)
  end
  
  it "#data_size returns datasize" do
    @yamdi.data_size.should eq(88470)
  end
  
  it "#audio_size returns audiosize" do
    @yamdi.audio_size.should eq(75958)
  end
  
  it "#video_size returns videosize" do
    @yamdi.video_size.should eq(11572)
  end
  
  it "#file_size returns filesize" do
    @yamdi.file_size.should eq(89137)
  end
  
  it "#last_timestamp returns lasttimestamp" do
    @yamdi.last_timestamp.should eq(6.06)
  end
  
  it "#last_video_frame_timestamp returns lastvideoframetimestamp" do
    @yamdi.last_video_frame_timestamp.should eq(6.04)
  end
  
  it "#last_key_frame_timestamp returns lastkeyframetimestamp" do
    @yamdi.last_key_frame_timestamp.should eq(6.04)
  end
  
  it "#last_key_frame_location returns lastkeyframelocation" do
    @yamdi.last_key_frame_location.should eq(83017)
  end
  
  context "key frames" do
    before(:all) do
      @key_frame_1 = @yamdi.key_frames.first
      @key_frame_2 = @yamdi.key_frames.last
    end
    
    it "returns an array of key frame open structs" do
       @yamdi.key_frames.class.should eq(Array)
       @yamdi.key_frames.first.class.should eq(OpenStruct)
       @yamdi.key_frames.last.class.should eq(OpenStruct)
    end
    
    it "returns the proper time values" do
      @key_frame_1.time.should eq(0.04)
      @key_frame_2.time.should eq(6.04)
    end
    
    it "returns the proper file position values" do
      @key_frame_1.file_position.should eq(1327)
      @key_frame_2.file_position.should eq(83017)
    end
  end
end