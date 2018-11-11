class ProductsController < ApplicationController
  before_action :set_product, only: %i(edit update destroy)

  def index
    @search = Product.search(params[:q])
    @products = @search.result.page params[:page]
  end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = t('.created_success')
      redirect_to products_path
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      flash[:success] = t('.updated_success')
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    flash[:success] = t('.delete_success')
    redirect_to products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :unit, :price, :company_id)
  end
end
