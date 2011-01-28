# Example rake task to refresh your flv metadata using yamdi
# This assumes that you are using paperclip and have a Video 
# model with an attachment of video.
# truncated example:
# class Video
#   has_attached_file :video,
#                     :styles => {:orginal => {}},
#                     :processors => [:metadata_extractor]
# end
#
# The rake task below even works when using Amazon s3 for storage
# thanks to Paperclip.


namespace :video do
  namespace :refresh do
    
    desc "Regenerates metadata for uploaded flv videos."
    task :metadata => :environment do
      errors = []
      # conditions assume default value of duration column has been set to 0
      Video.find(:all, :conditions => ['duration = 0']).each do |video|
        #ensure we are dealing with flv's
        next unless video.video_file_name && video.video_file_name.include?('.flv')
  
        result = video.video.reprocess!
        errors << [video.id, video.errors] unless video.errors.blank?
        result
      end
      errors.each{|e| puts "#{e.first}: #{e.last.full_messages.inspect}" }
    end
    
  end
end