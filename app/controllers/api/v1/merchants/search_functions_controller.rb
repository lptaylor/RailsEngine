class API::V1::Merchants::SearchFunctionsController < ApplicationController
  def index

  end

  def show
    render json: MerchantSerializer.new(search_params(params))
  end

  private

  def search_params(params)
    case params
      when params[:id]
        Merchant.where(id: params[:id])
      when params[:name]
        Merchant.where(name: params[:name])
      when params[:created_at]
        Merchant.where(created_at: params[:created_at])
      when params[:updated_at]
        Merchant.where(updated_at: parmas[:updated_at])
    end
  end
end
