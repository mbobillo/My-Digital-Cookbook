class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])

    if params[:tags].present?
      @selected_tags = Tag.where(id: params[:tags])
    else
      @selected_tags = []
    end

    @main_ingredient = params[:main_ingredient] if params[:main_ingredient].present?

  end
end
