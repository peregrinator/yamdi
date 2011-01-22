module Paperclip
  class MetadataExtractor < Paperclip::Processor
    def make
      # get the metadata from Yamdi
      metadata = Yamdi.new(file.path)
      
      # add values to the attachment instance (for db persistence, etc)
      # assumes duration is a column in the table this attachment is being
      # added to.
      attachment.instance.duration = metadata.duration
      
      # always return a reference to the file when done
      file
    end
  end
end