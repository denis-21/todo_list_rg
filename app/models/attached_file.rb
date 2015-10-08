class AttachedFile < ActiveRecord::Base

  mount_uploader :attachment, AttachmentUploader

  belongs_to :comment


end
