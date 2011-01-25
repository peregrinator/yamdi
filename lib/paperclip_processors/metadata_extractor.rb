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