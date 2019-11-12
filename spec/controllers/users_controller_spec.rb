require 'rails_helper'
require 'pp'

RSpec.describe UsersController, type: :controller do

	describe 'GET index' do
		before :each do
			@user1 = User.create(id: 1, name: 'John Doe', email: 'jdoe@berkeley.edu', auth: true, admin: true)
			@user2 = User.create(id: 2, name: 'Jane Doe', email: 'jdoe2@berkeley.edu', auth: true, admin: false)
			session[:user_id] = 1
			expect(User).to receive(:find).with(1).and_return(@user1)
		end

		it 'should call User#all' do
			expect(User).to receive(:all)
			get :index
		end

		it 'assigns @users' do
			expect(User).to receive(:all).and_return([@user1, @user2])
			expect(User).to receive(:all).and_return([@user1, @user2])
			get :index
			expect(assigns(:users)).not_to be_nil
			expect(assigns(:users)).to eq(User.all)
		end
	end
end
