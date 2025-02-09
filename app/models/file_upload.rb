class FileUpload < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  validates :file, presence: true

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
end
