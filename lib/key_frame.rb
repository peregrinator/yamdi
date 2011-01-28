require 'nokogiri'

class KeyFrame
  
  attr_accessor :time, :file_position
  
  def initialize(options = {})
    @time          = options[:time]
    @file_position = options[:file_position]
  end
  
  def self.all_from_xml(keyframe_xml)
    times          = get_times(keyframe_xml.xpath("//times/value"))
    file_positions = get_file_positions(keyframe_xml.xpath("//filepositions/value"))
    
    count = 0
    key_frames = []
    while count < times.size do
      key_frames << KeyFrame.new(:time => times[count], :file_position => file_positions[count])
      count = count + 1
    end
    
    key_frames
  end
  
  def self.get_times(times_data_xml)
    times = []
    times_data_xml.children.each do |el|
      times << el.inner_text.to_f
    end
    times
  end
  
  def self.get_file_positions(file_positions_xml)
    file_positions = []
    file_positions_xml.children.each do |el|
      file_positions << el.inner_text.to_i
    end
    file_positions
  end
end