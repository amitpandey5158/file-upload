class FileUploadsController < ApplicationController
    before_action :authenticate_user!
  
    def index
        if current_user.file_uploads.present?
        @files = current_user.file_uploads
        else
            render :new
        end
    end
  
    def new
      @file_upload = FileUpload.new
    end
  
    def create
        debugger
      @file_upload = current_user.file_uploads.new(file_upload_params)
      if @file_upload.save
        redirect_to file_uploads_path, notice: 'File uploaded successfully.'
      else
        render :new
      end
    end
  
    def destroy
      @file_upload = current_user.file_uploads.find(params[:id])
      @file_upload.destroy
      redirect_to file_uploads_path, notice: 'File deleted successfully.'
    end
  
    private
  
    def file_upload_params
      params.permit(:title, :description, :file)
    end
  end
  