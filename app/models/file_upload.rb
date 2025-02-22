class FileUpload < ApplicationRecord
  belongs_to :user
  has_many_attached :file
  validates :file, presence: true

  def short_code
    Base64.urlsafe_encode64("#{id}-#{created_at.to_i}")[0..7] # 8-character short code
  end
  
end
