class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show edit update destroy approve]

  def index
    @search = Invoice.includes(:customer).search(params[:q])
    @invoices = @search.result.page params[:page]
  end

  def show
    respond_to do |format|
      format.html
      format.js { render 'show_modal' }
    end
  end

  def new
    @invoice = Invoice.new
  end

  def edit; end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.user = current_user

    if @invoice.save
      @invoice.render_report
      flash[:success] = t('.created_success')
      redirect_to  invoices_path
    else
      render :new
    end
  end

  def update
    if @invoice.update(invoice_params)
      @invoice.render_report
      flash[:success] = t('.updated_success')
      redirect_to invoices_path
    else
      render :edit
    end
  end

  def destroy
    @invoice.destroy
    flash[:success] = t('.delete_success')
    redirect_to invoices_url
  end

  def download
    @invoice = Invoice.find(params[:id])
    data = InvoiceSerializer.new(@invoice).to_json

    send_data data, :type => 'application/json', :disposition => "attachment; ", filename: "invoice.json"
  end

  def approve
    return unless current_user.owner?
    @invoice.cancle_prev_invoice
    @invoice.approved!
    @invoice.render_report
    @invoice.delete_all_draft
    flash[:success] = t('.updated_success')
  end

  def cancle
    flash[:alert] = t('.warning_cancle')
    old_invoice = Invoice.find(params[:id])
    @invoice = old_invoice.deep_clone include: :items
    @invoice.hash_data =  nil
    @invoice.transaction_id =  nil
    @invoice.hash_data =  nil
    @invoice.form_identifier =  nil
    @invoice.invoice_date =  nil
    @invoice.serial_number =  nil
    @invoice.invoice_number =  nil
    @invoice.prev_invoice = old_invoice.id
  end

  def multi_approve
    return unless current_user.owner?
    invoices = Invoice.pending.where(id: params[:invoice_ids])

    invoices.each do |invoice|
      invoice.cancle_prev_invoice
      invoice.approved!
      invoice.render_report
      invoice.delete_all_draft
    end
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(
      :form_identifier, :serial_number, :invoice_number,
      :invoice_date, :payment_method, :total, :vat_percent, :customer_id,
      :vat_amount, :customer_paid_amount, :prev_invoice,
      items_attributes: [:id, :product_id, :quantity, :price, :_destroy])
  end
end
