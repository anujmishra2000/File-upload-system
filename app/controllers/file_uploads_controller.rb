class FileUploadsController < ApplicationController
  before_action :authenticate_user!, except: :short_url_redirect

  def index
    @files = current_user.file_uploads
  end

  def new
    @file_upload = FileUpload.new
  end

  def create
    @file_upload = current_user.file_uploads.new(file_upload_params)

    if @file_upload.save
      flash[:notice] = 'File uploaded successfully'
      redirect_to file_uploads_path
    else
      flash[:alert] = 'File upload failed'
      render :new
    end
  end

  def destroy
    @file = current_user.file_uploads.find(params[:id])
    @file.destroy
    flash[:notice] = 'File deleted'
    redirect_to file_uploads_path
  end

  def generate_public_url
    @file = current_user.file_uploads.find(params[:id])

    if @file.public_url.blank?
      @file.generate_public_url  # ✅ Generate the short URL
      @file.reload
    end

    redirect_to file_uploads_path, notice: "Public URL generated successfully."
  end

  def short_url_redirect
    @file = FileUpload.find_by(public_url: params[:public_url])

    if @file.present?
      redirect_to rails_blob_url(@file.file), allow_other_host: true
    else
      render plain: "Invalid or expired link", status: :not_found
    end
  end

  private

  def file_upload_params
    params.require(:file_upload).permit(:title, :description, :file)
  end
end
