class FileUploadsController < ApplicationController
  	before_action :authenticate_user!, except: [:public_access]
  
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

		def public_access
			short_code = params[:short_code]
			file_upload = find_file_by_short_code(short_code)
	
			if file_upload.present?
				redirect_to rails_blob_url(file_upload.file.first) # Redirect to file URL
			else
				render plain: "File not found", status: :not_found
			end
		end
	
		private
	
		def file_upload_params
			params.permit(:title, :description, :file)
		end
	
		def find_file_by_short_code(short_code)
			FileUpload.all.detect { |file| file.short_code == short_code } # Match dynamically
		end
	end