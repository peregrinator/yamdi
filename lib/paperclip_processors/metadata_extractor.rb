# This assumes that you are using paperclip.
# For example you may Video model with an attachment of video.
# truncated example:
# class Video
#   has_attached_file :video,
#                     :styles => {:orginal => {}},
#                     :processors => [:metadata_extractor]
# end
#
# Remember for processors to work you must define styles on
# has_attached_file. Even if they are just blank as the example
# above. Without them processors won't be triggered.

module Paperclip
  class MetadataExtractor < Paperclip::Processor
    def make
      # get the metadata from Yamdi
      metadata = Yamdi.new(file.path)
      
      # add values to the attachment instance (for db persistence, etc)
      # assumes duration is a column in the table this attachment is being
      # added to.
      
      # a simple assignment works if you are not background processing your 
      # paperclip processing
      attachment.instance.duration = metadata.duration

      # if you are background processing your paperclip processing which is 
      # common when working with videos you'll want to ensure the instance gets
      # saved at some point in the processor chain, use:
      # attachment.instance.update_attribute(:duration, metadata.duration)
      
      # always return a reference to the file when done
      file
    end
  end
end