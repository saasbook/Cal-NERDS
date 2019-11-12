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
			get :index
			expect(assigns(:users)).not_to be_nil
			expect(assigns(:users)).to eq(User.all)
		end
	end

	describe 'GET new' do
		before :each do
			@user1 = User.create(id: 1, name: 'John Doe', email: 'jdoe@berkeley.edu', auth: true, admin: true)
			@user2 = User.create(id: 2, name: 'Jane Doe', email: 'jdoe2@berkeley.edu', auth: true, admin: false)
			session[:user_id] = 1
			expect(User).to receive(:find).with(1).and_return(@user1)
		end

		it 'should call User#new' do
			expect(User).to receive(:new)
			get :new
		end

		it 'should assign @user' do
			get :new
			expect(assigns(:user)).not_to be_nil
		end
	end

	describe 'POST create' do
		before :each do
			@user1 = User.create(id: 1, name: 'John Doe', email: 'jdoe@berkeley.edu', auth: true, admin: true)
			session[:user_id] = 1
			post :create, {user: {name: "Jane Doe", email: "jdoe2@berkeley.edu"}}
		end

		it 'should assign @user' do
			expect(assigns(:user)).not_to be_nil
		end

		it 'should create a new user' do
			expect(User.all.length).to eq(2)
			expect(User.find(2).name).to eq("Jane Doe")
		end

		it 'should redict to the user page' do
			expect(response).to redirect_to(assigns(:user))
		end
	end
end
