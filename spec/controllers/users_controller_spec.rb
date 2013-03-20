require 'spec_helper'

describe UsersController do
	let(:users) { arr = []; 3.times { arr << FactoryGirl.build(:user) };arr }
  let(:user) { FactoryGirl.build(:user) }

	describe 'GET index' do
		before do
			User.stub(:all).and_return(users)
			get :index, format: :json
		end
		it "is successful" do
			expect(response).to be_success
		end
	end

  describe 'POST create' do
    context 'with valid credentials' do
      before do
				User.should_receive(:build).and_return(user)
				user.stub!(:save).and_return(true)
			end

			it "responds with a 201" do
				post :create, format: :json
				expect(response.code).to eql("201")
			end
    end

    context 'with invalid credentials' do
      before do
				User.should_receive(:build).and_return(user)
				user.stub!(:save).and_return(false)
			end

			it "responds with a 422" do
        post :create, format: :json
				expect(response.code).to eql("422")
      end
    end
  end

#  describe 'when posting to the authenticate action' do
#    describe 'with valid credentials' do
#      setup do
#        @user = FactoryGirl.build(:user)
#        @user.stubs(:token).returns(SecureRandom.uuid)
#        User.stubs(:find_by_email).returns(@user)
#        @user.stubs(:authenticate).returns(@user)
#        post :authenticate
#      end
#      should respond_with :success
#    end
#
#    describe 'with invalid credentials' do
#      setup do
#        @user = FactoryGirl.build(:user)
#        @user.stubs(:token).returns(SecureRandom.uuid)
#        User.stubs(:find_by_email).returns(@user)
#        @user.stubs(:authenticate).returns(false)
#        post :authenticate
#      end
#      should respond_with 401
#    end
#  end

end
