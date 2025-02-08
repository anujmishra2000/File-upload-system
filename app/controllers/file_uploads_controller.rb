class FileUploadsController < ApplicationController
  before_action :authenticate_user!

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

  def share
    @file = current_user.file_uploads.find(params[:id])
    @file.update!(public_url: @file.short_url)
    flash[:notice] = 'File shared successfully'
    redirect_to file_uploads_path
  end

  private

  def file_upload_params
    params.require(:file_upload).permit(:title, :description, :file)
  end
end
