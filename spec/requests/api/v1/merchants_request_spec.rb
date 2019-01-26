require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 7)

    get '/api/v1/merchants'

    expect(response).to be_successful

    data = JSON.parse(response.body)
    merchants = data["data"]

    expect(merchants.count).to eq(7)
  end

  it "can return a merchant by id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"
    
    data = JSON.parse(response.body)
    merchant = data["data"]

    expect(merchant["id"]).to eq(id.to_s)
  end

end
