require 'tempfile'
require 'ostruct'

class Yamdi
  
  def initialize(flv_path)
    @metadata = Nokogiri.parse( parse(flv_path) )
  end
  
  def parse(flv_path)
    temp_file = Tempfile.new('yamdi_tmp')
    `yamdi -i #{flv_path} -x #{temp_file.path}`
    contents = temp_file.read
    temp_file.close
    contents
  end
  
  def duration
    @metadata.xpath("//duration").inner_text.to_f
  end
  
  def has_keyframes?
    boolean @metadata.xpath("//hasKeyframes").inner_text
  end
  
  def has_video?
    boolean @metadata.xpath("//hasVideo").inner_text
  end
  
  def has_audio?
    boolean @metadata.xpath("//hasAudio").inner_text
  end
  
  def has_metadata?
    boolean @metadata.xpath("//hasMetadata").inner_text
  end
  
  def has_cue_points?
    boolean @metadata.xpath("//hasCuePoints").inner_text
  end
  
  def can_seek_to_end?
    boolean @metadata.xpath("//canSeekToEnd").inner_text
  end
  
  def audio_codec_id
    @metadata.xpath("//audiocodecid").inner_text.to_i
  end
  
  def audio_sample_rate
    @metadata.xpath("//audiosamplerate").inner_text.to_i
  end
  
  def audio_data_rate
    @metadata.xpath("//audiodatarate").inner_text.to_i
  end
  
  def audio_sample_size
    @metadata.xpath("//audiosamplesize").inner_text.to_i
  end
  
  def audio_delay
    @metadata.xpath("//audiodelay").inner_text.to_f
  end
  
  def stereo?
    boolean @metadata.xpath("//stereo").inner_text
  end
  
  def video_codec_id
    @metadata.xpath("//videocodecid").inner_text.to_i
  end
  
  def frame_rate
    @metadata.xpath("//framerate").inner_text.to_f
  end
  
  def video_data_rate
    @metadata.xpath("//videodatarate").inner_text.to_i
  end
  
  def height
    @metadata.xpath("//height").inner_text.to_i
  end
  
  def width
    @metadata.xpath("//width").inner_text.to_i
  end
  
  def data_size
    @metadata.xpath("//datasize").inner_text.to_i
  end
  
  def audio_size
    @metadata.xpath("//audiosize").inner_text.to_i
  end
  
  def video_size
    @metadata.xpath("//videosize").inner_text.to_i
  end
  
  def file_size
    @metadata.xpath("//filesize").inner_text.to_i
  end
  
  def last_timestamp
    @metadata.xpath("//lasttimestamp").inner_text.to_f
  end
  
  def last_video_frame_timestamp
    @metadata.xpath("//lastvideoframetimestamp").inner_text.to_f
  end
  
  def last_key_frame_timestamp
    @metadata.xpath("//lastkeyframetimestamp").inner_text.to_f
  end
  
  def last_key_frame_location
    @metadata.xpath("//lastkeyframelocation").inner_text.to_i
  end
  
  def key_frames
    times_data_xml = @metadata.xpath("//keyframes/times/value")
    times = []
    times_data_xml.children.each do |el|
      times << el.inner_text.to_f
    end
    
    file_positions_xml = @metadata.xpath("//keyframes/filepositions/value")
    file_positions = []
    file_positions_xml.children.each do |el|
      file_positions << el.inner_text.to_i
    end
    
    count = 0
    key_frames = []
    while count < times.size do
      key_frames << OpenStruct.new(:time => times[count], :file_position => file_positions[count])
      count = count + 1
    end
    
    key_frames
  end
  
  private
  
  def boolean(string)
    string == 'true' ? true : (string == 'false' ? false : string)
  end
end