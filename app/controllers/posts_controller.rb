class PostsController < ApplicationController
  include ::ActivityLogs::Loggable

  before_action :set_object, only: %i[show edit update destroy]
  after_action :create_log, only: %i[create update destroy]
  before_action :load_action_context, only: %i[create update destroy]
  before_action :verify_params, only: %i[create update]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @object = Post.new
  end

  def edit; end

  def create
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to posts_path, notice: 'Dodano post' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to posts_path, notice: 'Edytowano post' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to posts_path, notice: 'Usunięto post' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_object
    @object = Post.find(params[:id])
  end

  def permitted_params
    params.fetch(:post, params).permit!
  end

  def action_subject
    :post
  end
end
