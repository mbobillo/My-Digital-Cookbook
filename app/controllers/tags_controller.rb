class TagsController < ApplicationController
  def new
    @tag = Tag.new
  end

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end
end
