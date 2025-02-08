class FileUpload < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  validates :file, presence: true

  before_create :generate_short_url

  private

  def generate_short_url
    self.short_url = Shortener::ShortenedUrl.generate("#{Rails.application.routes.url_helpers.rails_blob_url(file)}")
  end
end
