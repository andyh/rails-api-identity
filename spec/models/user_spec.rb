require 'spec_helper'

describe User do
	subject(:user) { FactoryGirl.build(:user) }
	it { expect(user).to be_valid }
	it { expect(user).to validate_presence_of :email }

	context 'when creating a user' do
		before { user.save }
		it { expect(user).to validate_uniqueness_of :email }
		it 'sets the token' do
			expect(user.token).to be_true
		end	
	end
end
