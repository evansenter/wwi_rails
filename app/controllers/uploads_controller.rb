class UploadsController < ApplicationController
  before_filter :require_verified_user!
  before_filter :require_admin!, only: [:new, :create, :destroy]

  include Transloadit::Rails::ParamsDecoder

  def index; end

  def new
    @upload = Upload.new
  end

  def create
    @upload = current_user.uploads.build(upload_params)

    if params[:transloadit] && params[:transloadit][:ok] == "ASSEMBLY_COMPLETED"
      @upload.s3_url = params[:transloadit][:results][":original"].first[:ssl_url] rescue nil
    end

    if @upload.save
      flash.notice = "Your document has been created!"
      redirect_to documents_path
    else
      render "new"
    end
  end

  def destroy
    Upload.find(params[:id]).destroy
    flash.notice = "The file has been permanently deleted."

    redirect_to uploads_path
  end

  private

  def upload_params
    params.require(:upload).permit(:title, :category)
  end
end
