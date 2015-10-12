# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

=begin
begin
  if Rails.env.production?
    include Cloudinary::CarrierWave
  else

    storage :file

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end
end
=end

end
