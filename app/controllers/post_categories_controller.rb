# frozen_string_literal: true

class PostCategoriesController < ApplicationController
  include ::Authentication::AdminController

  before_action :check_ability
  before_action :set_post_category, only: %i[show edit update destroy]

  def index
    @post_categories = PostCategory.all
  end

  def show; end

  def new
    @post_category = PostCategory.new
  end

  def edit; end

  def create
    @post_category = PostCategory.new(post_category_params)

    respond_to do |format|
      if @post_category.save
        format.html { redirect_to post_category_url(@post_category), notice: 'Post category was successfully created.' }
        format.json { render :show, status: :created, location: @post_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post_category.update(post_category_params)
        format.html { redirect_to post_category_url(@post_category), notice: 'Post category was successfully updated.' }
        format.json { render :show, status: :ok, location: @post_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post_category.destroy!

    respond_to do |format|
      format.html { redirect_to post_categories_url, notice: 'Post category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post_category
    @post_category = PostCategory.find(params[:id])
  end

  def post_category_params
    params.require(:post_category).permit(:name)
  end
end
