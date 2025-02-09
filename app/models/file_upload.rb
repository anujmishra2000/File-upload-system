class FileUpload < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  validates :file, presence: true
  validate :file_size_validation

  def get_public_url
    return unless public_url.present?
    "http://localhost:3000/shared/#{public_url}"
  end

  def generate_public_url
    key = loop do
      random_key = SecureRandom.alphanumeric(8)  # Generates a random 8-character key
      break random_key unless FileUpload.exists?(public_url: random_key)
    end
    self.update(public_url: key)
  end

  private

  def file_size_validation
    if file.attached? && file.blob.byte_size > 1.megabyte
      errors.add(:base, "File size must be less than 1GB")
    end
  end
end
