# == Schema Information
#
# Table name: uploads
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  category   :string(255)
#  s3_url     :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  published  :boolean          default(FALSE)
#

class UploadsController < ApplicationController
  before_filter :require_authorized_user!, only: [:new, :create, :destroy]

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
      flash.notice = "Your document has been created. After it is verified by an editor, it will be published."
      redirect_to articles_path
    else
      render "new"
    end
  end

  def destroy
    Upload.find(params[:id]).destroy
    flash.notice = "The file has been permanently deleted."

    redirect_to articles_path
  end

  private

  def upload_params
    params.require(:upload).permit(:title, :category)
  end
end
