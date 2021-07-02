#class Attachment < ApplicationRecord
class Attachment < ActiveRecord::Base
    belongs_to :attachmentable, polymorphic: true, optional: true
    mount_uploader :file, FileUploader
end
  