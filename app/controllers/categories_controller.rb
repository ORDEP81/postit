class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))

    if @category.save 
      flash[:notice] = 'Category has been created'
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @category = Category.find(param[:id])
  end
end