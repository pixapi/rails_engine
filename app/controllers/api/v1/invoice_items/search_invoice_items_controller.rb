class Api::V1::InvoiceItems::SearchInvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItem.where(invoice_items_params)
  end

  def show
    render json: InvoiceItem.find_by(invoice_items_params)
  end

  private

  def invoice_items_params
     if params[:unit_price]
      params[:unit_price] = params[:unit_price].delete(".")
    end
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
