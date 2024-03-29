# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text(65535)
#  published  :boolean
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostsController < ApplicationController
  before_filter :require_admin!, except: [:index, :show]
  before_filter :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.order("created_at DESC")
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else
      render "new"
    end

  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    flash.post = "The post has been permanently deleted."

    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
