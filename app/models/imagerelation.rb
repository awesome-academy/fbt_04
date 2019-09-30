class Imagerelation < ApplicationRecord
  belongs_to :user
  belongs_to :imagetable, polymorphic: true
  mount_uploader :picture, PictureUploader
end
