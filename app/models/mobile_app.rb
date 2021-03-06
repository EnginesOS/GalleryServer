class MobileApp < ActiveRecord::Base

  belongs_to :published_software
  # has_many :mobile_app_screenshots, dependent: :destroy
  has_attached_file :image, dependent: :destroy

  attr_accessor :delete_image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  before_validation { image.clear if delete_image == '1' }

end
