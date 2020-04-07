# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :render_user_unauthorized

  def index
    @posts = Post.all.page(params[:page]).per(10)
  end

  def show
    @post = current_post
  end

  def new
    @post = current_user.posts.new
  end

  def edit
    @post = current_post
  end

  def create
    post = current_user.posts.new(post_params)

    respond_to do |format|
      if post.save
        format.html { redirect_to post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: post }
      else
        format.html { render :new }
        format.json { render json: post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if current_post.update(post_params)
        format.html { redirect_to current_post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: current_post }
      else
        format.html { render :edit }
        format.json { render json: current_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    current_post.destroy!
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def current_post
    @post = authorize(Post.find(params[:id]))
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
