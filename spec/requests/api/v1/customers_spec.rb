require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 5)

    get '/api/v1/customers'

    expect(response).to be_success

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(5)
  end

  it "can get one customer by its id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["id"]).to eq(id)
  end

  it "returns a single merchant by id" do
    customer = create(:customer)

    get "/api/v1/customers/find?#{customer.id}"

    returned_merchant =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_merchant["id"]).to eq(customer.id)
  end

  it "returns a single customer by first name" do
    customer = create(:customer)

    get "/api/v1/customers/find?#{customer.first_name}"

    returned_merchant =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_merchant["first_name"]).to eq(customer.first_name)
  end

  it "returns a single customer by last name" do
    customer = create(:customer)

    get "/api/v1/customers/find?#{customer.last_name}"

    returned_merchant =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_merchant["last_name"]).to eq(customer.last_name)
  end

  it "returns a single customer by created_at" do
    customer = create(:customer)

    get "/api/v1/customers/find?#{customer.created_at}"

    returned_merchant =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_merchant["created_at"]).to eq("2014-11-07T12:12:12.000Z")
  end

  it "returns a single customer by updated_at" do
    customer = create(:customer)

    get "/api/v1/customers/find?#{customer.updated_at}"

    returned_merchant =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_merchant["updated_at"]).to eq("2014-11-07T12:12:12.000Z")
  end

  it "returns all customers with an id" do
    customer1 = create(:customer)
    customer2 = create(:customer)

    get "/api/v1/customers/find_all?id=#{customer1.id}"

    returned_customers = JSON.parse(response.body)
    first_customer = returned_customers.first

    expect(response).to be_success
    expect(returned_customers.count).to eq(1)
    expect(first_customer["id"]).to eq(customer1.id)
  end

  xit "returns all customers with a name" do
    merchant1 = create(:customer, name: "Shop")
    merchant2 = create(:customer, name: "Shopify")
    merchant3 = create(:customer, name: "Craftsy")

    get "/api/v1/customers/find_all?name=#{merchant1.name}"

    returned_merchants = JSON.parse(response.body)
    first_merchant = returned_merchants.first

    expect(response).to be_success
    expect(returned_merchants.count).to eq(2)
    expect(first_merchant["name"]).to eq(merchant1.name)
  end

  it "returns all customers with same created_at" do
    create_list(:customer, 3)

    get "/api/v1/customers/find_all?created_at=2014-11-07T12:12:12.000Z"


    returned_merchants = JSON.parse(response.body)
    first_merchant = returned_merchants.first

    expect(response).to be_success
    expect(returned_merchants.count).to eq(3)
  end

  it "returns all customers with same updated_at" do
    create_list(:customer, 3)

    get "/api/v1/customers/find_all?updated_at=2014-11-07T12:12:12.000Z"

    returned_merchants = JSON.parse(response.body)
    first_merchant = returned_merchants.first

    expect(response).to be_success
    expect(returned_merchants.count).to eq(3)
  end

  it "returns a random customer record" do
    create_list(:customer, 3)
    get '/api/v1/customers/random'

    returned_customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_customer.class).to eq(Hash)
  end
end
