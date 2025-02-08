class AddShortUrlToFileUploads < ActiveRecord::Migration[8.0]
  def change
    add_column :file_uploads, :short_url, :string
  end
end
