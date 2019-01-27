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

  it "can find a single merchant by an id" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant.id}"

    data = JSON.parse(response.body)
    merchant_data = data["data"]
    expect(merchant_data["id"]).to eq(merchant.id.to_s)
  end

  xit "can find a single merchant by a name" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"

    data = JSON.parse(response.body)
    merchant_data = data["data"]

    expect(merchant_data["name"]).to eq(merchant.name.to_s)
  end

  xit "can find a single merchant by a created_at time" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

    data = JSON.parse(response.body)
    merchant_data = data["data"]

    expect(merchant_data["created_at"]).to eq(merchant.created_at.to_s)
  end

  xit "can find a single merchant by a updated_at time" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

    data = JSON.parse(response.body)
    merchant_data = data["data"]

    expect(merchant_data["updated_at"]).to eq(merchant.updated_at.to_s)
  end


end
