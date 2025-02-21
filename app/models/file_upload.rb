class FileUpload < ApplicationRecord
  belongs_to :user
  has_many_attached :file
  validates :file, presence: true
end
