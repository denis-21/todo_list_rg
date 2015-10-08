# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

=begin
  if Rails.env.production?
    include Cloudinary::CarrierWave
  else
=end

    storage :file
    # storage :fog

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
 # end

end
