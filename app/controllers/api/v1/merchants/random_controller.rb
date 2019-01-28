class Api::V1::Merchants::RandomController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find(Merchant.random_record))
  end

end
