class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]

  def index
    @search = Customer.search(params[:q])
    @customers = @search.result.page params[:page]
  end

  def show; end

  def new
    @customer = Customer.new
  end

  def edit; end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      flash[:success] = t('.created_success')
      redirect_to customers_path
    else
      render :new
    end
  end

  def update
    if @customer.update(customer_params)
      flash[:success] = t('.updated_success')
      redirect_to customers_path
    else
      render :edit
    end
  end

  def destroy
    @customer.destroy
    flash[:success] = t('.delete_success')
    redirect_to customers_path
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :address, :phone_number, :email, :company_name, :tax_number)
  end
end
