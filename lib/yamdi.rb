require 'tempfile'
require 'ostruct'
require 'nokogiri'

require 'key_frame'

class Yamdi
  
  attr_accessor :metadata
  
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
    KeyFrame.all_from_xml(@metadata.xpath("//keyframes"))
  end
  
  private
  
  def boolean(string)
    string == 'true' ? true : (string == 'false' ? false : string)
  end
end