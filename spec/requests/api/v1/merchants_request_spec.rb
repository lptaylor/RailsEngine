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
    expect(merchant_data["attributes"]["id"]).to eq(merchant.id)
  end

  it "can find a single merchant by a name" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"
    data = JSON.parse(response.body)
    merchant_data = data["data"]

    expect(merchant_data["attributes"]["name"]).to eq(merchant.name.to_s)
  end

  it "can find a single merchant by a created_at time" do
    merchant = create(:merchant, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"
    data = JSON.parse(response.body)
    merchant_data = data["data"]

    expect(merchant_data["attributes"]["id"]).to eq(merchant.id)
  end

  it "can find a single merchant by a updated_at time" do
    merchant = create(:merchant, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

    data = JSON.parse(response.body)
    merchant_data = data["data"]

    expect(merchant_data["attributes"]["id"]).to eq(merchant.id)
  end

  describe "multi finders" do
    before(:each) do
      @merchant = create(:merchant, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
      @merchant_2 = create(:merchant, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
      create_list(:merchant, 10)
      create(:merchant, name: "John", created_at: 2.days.ago, updated_at: 3.days.ago)
    end
    it 'can find all merchants by name' do
      get "/api/v1/merchants/find_all?name=#{@merchant.name}"
      data = JSON.parse(response.body)
      merchant_data = data["data"]

      expect(merchant_data.count).to eq(12)
    end

    it 'finds all merchants by created_at' do
      get "/api/v1/merchants/find_all?created_at=#{@merchant.created_at}"
      data = JSON.parse(response.body)
      merchant_data = data["data"]

      expect(merchant_data.count).to eq(2)
    end

    it 'finds all merchants by updated_at' do
      get "/api/v1/merchants/find_all?updated_at=#{@merchant.updated_at}"
      data = JSON.parse(response.body)
      merchant_data = data["data"]

      expect(merchant_data.count).to eq(2)
    end
  end

  describe 'business methods' do
    before(:each) do
      @merchant = create(:merchant, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
      @merchant_2 = create(:merchant, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
      create_list(:merchant, 10)
      create(:merchant, name: "John", created_at: 2.days.ago, updated_at: 3.days.ago)
    end

    it 'returns a random record when queried' do
      get "/api/v1/merchants/random"

      expect(response).to be_successful
      data = JSON.parse(response.body)
      expect(data.count).to eq(1)
    end

    it 'shows invoices for a merchant' do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice_1 = create(:invoice, merchant: merchant, customer: customer)
      invoice_2 = create(:invoice, merchant: merchant, customer: customer)
      invoice_3 = create(:invoice, merchant: merchant, customer: customer)
      create_list(:invoice, 10, merchant: merchant, customer: customer)

      get "/api/v1/merchants/#{merchant.id}/invoices"

      invoices = JSON.parse(response.body)["data"]
      expect(invoices.count).to eq(13)
      expect(invoices.first["attributes"]["id"]).to eq(invoice_1.id)
    end

    it 'shows items for a merchant' do
     merchant = create(:merchant)
     merchant_2 = create(:merchant)
     item_1 = create(:item, merchant: merchant)
     item_2 = create(:item, merchant: merchant_2)
     item_3 = create(:item, merchant: merchant)
     create_list(:item, 10, merchant: merchant)

     get "/api/v1/merchants/#{merchant.id}/items"


     items = JSON.parse(response.body)["data"]
     expect(items.count).to eq(13)
     expect(items.first["attributes"]["id"]).to eq(item_1.id)
   end

   it 'returns ordered list of merchants by revenue' do
     merchant = create(:merchant)
     merchant_2 = create(:merchant)
     merchant_3 = create(:merchant)
     merchant_4 = create(:merchant)

     customer = create(:customer)

     item_1 = create(:item, merchant: merchant)
     item_2 = create(:item, merchant: merchant_2)
     item_3 = create(:item, merchant: merchant_3)
     item_4 = create(:item, merchant: merchant_4)

     invoice_1 = create(:invoice, customer: customer, merchant: merchant)
     invoice_2 = create(:invoice, customer: customer, merchant: merchant_2)
     invoice_3 = create(:invoice, customer: customer, merchant: merchant_3)
     invoice_4 = create(:invoice, customer: customer, merchant: merchant_4)

     invoice_item_1 = create(:invoice_item, invoice: invoice_1 , item: item_1 , quantity: 1, unit_price: 10)
     invoice_item_2 = create(:invoice_item, invoice: invoice_2 , item: item_2 , quantity: 100, unit_price: 25)
     invoice_item_3 = create(:invoice_item, invoice: invoice_3 , item: item_3 , quantity: 1, unit_price: 100)
     invoice_item_4 = create(:invoice_item, invoice: invoice_4 , item: item_4 , quantity: 1, unit_price: 500)

     get '/api/v1/merchants/most_revenue?quantity=3'

     expect(response).to be_successful

     ordered_merch = (JSON.parse(response.body))["data"]
     expect(ordered_merch.count).to eq(3)
     expect(ordered_merch[0]["id"]).to eq(merchant_2.id)
   end
  end
end
