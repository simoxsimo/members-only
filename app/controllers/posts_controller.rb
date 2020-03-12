class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:success] = 'Post have been created!'
      redirect_to posts_path
    end
  end

  def index
    @post = Post.all
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
