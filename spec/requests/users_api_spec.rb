require 'spec_helper'

UUID_REGEX = /^([0-9a-f]{8})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{2})([0-9a-f]{2})-([0-9a-f]{12})$/
describe "Users" do
  let!(:users) do
    users_array = []
    3.times { users_array << FactoryGirl.create(:user)}
    users_array
  end

  describe "GET 'users.json'" do
    it "returns the list of lists" do
      get "/users.json"
      expect(response.body).to eql users.to_json
    end
  end

  describe "creating a user" do
    context "with valid details" do
      it "allows clients to create a user" do
        post users_url, user: {email: "andy@foxsoft.co.uk", password: "password", password_confirmation: "password"}, format: "json"
        expect(response.status).to eql(201)
      end
    end
    context "with invalid details" do
      it "responds with a 422" do
        post users_url, user: {email: "andy@foxsoft.co.uk"}, format: "json"
        expect(response.status).to eql(422)
      end
    end
  end

  describe "authenticating a user" do
    let!(:user) { FactoryGirl.create(:user, password: "password") }
    context "with valid credentials" do
      before { post authenticate_users_url, {email: user.email, password: "password"}, format: "json"}
      it "responds with success" do
        expect(response.status).to eq(200)
      end

      it "returns a token" do
        expect(response.body).to match UUID_REGEX
      end
    end

    context "with invalid credentials" do
      before { post authenticate_users_url, {email: "bob"}, format: "json" }
      it "responds with 401" do
        expect(response.status).to eq(401)
      end

      it "returns a failure message" do
        expect(response.body).to match /authentication failed/i
      end
    end
  end
end
