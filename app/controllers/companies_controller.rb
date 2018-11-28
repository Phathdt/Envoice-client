class CompaniesController < ApplicationController
  before_action :set_company

  def edit; end

  def update
    if @company.update(company_params)
      flash[:success] = t('.updated_success')
      redirect_to edit_company_path(@company)
    else
      render :edit
    end
  end

  private

  def set_company
    @company = Company.first
  end

  def product_params
    params.require(:product).permit(:name, :unit, :price, :company_id)
  end
end
