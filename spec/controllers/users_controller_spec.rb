require 'rails_helper'
require 'pp'

RSpec.describe UsersController, type: :controller do

	describe 'UsersController#check_user_permissions' do
		before :each do
			@user1 = User.create(id: 1, name: 'John Doe', email: 'jdoe@berkeley.edu', auth: true, admin: true)
			@user2 = User.create(id: 2, name: 'Jane Doe', email: 'jdoe2@berkeley.edu', auth: true, admin: false)
			@user3 = User.create(id: 3, name: 'Jen Doe', email: 'jdoe3@berkeley.edu', auth: false, admin: false)
		end

		it 'should redirect if no one is logged in' do
			get :index
			expect(response.status).to eq(302)
		end

		it 'should flash a notice if no one is logged in' do
			get :index
			expect(response.request.flash.notice).to eq("You are not logged in.")
		end

		it 'should redirect if not an auth user' do
			expect(User).to receive(:find).with(3).and_return(@user3)
			session[:user_id] = 3
			get :index
			expect(response.status).to eq(302)
		end

		it 'should flash a message if not an auth user' do
			expect(User).to receive(:find).with(3).and_return(@user3)
			session[:user_id] = 3
			get :index
			expect(response.request.flash.notice).to eq("You are not authorized to access this page.")
		end
	end

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

		it 'should render the index template' do
			get :index
			expect(response).to render_template :index
		end
	end

	describe 'GET show' do
		before :each do
			@user1 = User.create(id: 1, name: 'John Doe', email: 'jdoe@berkeley.edu', auth: true, admin: true)
			@user2 = User.create(id: 2, name: 'Jane Doe', email: 'jdoe2@berkeley.edu', auth: true, admin: false)
			@user3 = User.create(id: 3, name: 'Jen Doe', email: 'jdoe3@berkeley.edu', auth: false, admin: false)
		end

		it 'should redirect if the user is not an admin' do
			expect(User).to receive(:find).with(2).and_return(@user2)
			session[:user_id] = 2
			get :show, :id => 3
			expect(response.status).to eq(302)
		end

		it 'should flash a message if the user is not an admin' do
			expect(User).to receive(:find).with(2).and_return(@user2)
			session[:user_id] = 2
			get :show, :id => 3
			expect(response.request.flash.notice).to eq("You are not authorized to access this page.")
		end

		it 'should render the show template' do
			expect(User).to receive(:find).with(1).and_return(@user1)
			expect(User).to receive(:find).with("2").and_return(@user2)
			session[:user_id] = 1
			get :show, id: 2
			expect(response).to render_template :show
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

		it 'should render the new template' do
			get :new
			expect(response).to render_template :new
		end
	end

	describe 'POST create' do
		before :each do
			@user1 = User.create(id: 1, name: 'John Doe', email: 'jdoe@berkeley.edu', auth: true, admin: true)
			session[:user_id] = 1
		end

		it 'should assign @user' do
			post :create, {user: {name: "Jane Doe", email: "jdoe2@berkeley.edu"}}
			expect(assigns(:user)).not_to be_nil
		end

		it 'should create a new user' do
			post :create, {user: {name: "Jane Doe", email: "jdoe2@berkeley.edu"}}
			expect(User.all.length).to eq(2)
			expect(User.find(2).name).to eq("Jane Doe")
		end

		it 'should redict to the users index page' do
			post :create, {user: {name: "Jane Doe", email: "jdoe2@berkeley.edu"}}
			expect(response).to redirect_to(users_path)
		end

		it 'should render the new template if unsuccessful' do
			expect_any_instance_of(User).to receive(:save).and_return(false)
			post :create, {user: {name: "Jane Doe", email: "jdoe2@berkeley.edu"}}
			expect(response).to render_template :new
		end
	end

	describe 'GET edit' do
		before :each do
			@user1 = User.create(id: 1, name: 'John Doe', email: 'jdoe@berkeley.edu', auth: true, admin: true)
			@user2 = User.create(id: 2, name: 'Jane Doe', email: 'jdoe2@berkeley.edu', auth: true, admin: false)
			session[:user_id] = "1"
		end

		it 'should do be a success' do
			get :edit, {id: 2}
			expect(response.status).to eq(200)
		end

		it 'should assign @user' do
			get :edit, {id: 2}
			expect(assigns(:user)).to eq(@user2)
		end

		it 'should render the edit template' do
			get :edit, {id: 2}
			expect(response).to render_template :edit
		end
	end

	describe 'PATCH update' do
		before :each do 
			@user1 = User.create(id: 1, name: 'John Doe', email: 'jdoe@berkeley.edu', auth: true, admin: true)
			@user2 = User.create(id: 2, name: 'Jane Doe', email: 'jdoe2@berkeley.edu', auth: true, admin: false)
			session[:user_id] = 1
			expect(User).to receive(:find).with(1).and_return(@user1)
		end

		it 'should call User#update' do
			expect(User).to receive(:find).with("2").and_return(@user2)
			expect(@user2).to receive(:update)
			patch :update, {id: 2, user: {id: 2, email: 'janedoe@berkeley.edu'}}
		end

		it 'should redirect to the users index page if successful' do
			expect(User).to receive(:find).with("2").and_return(@user2)
			expect(@user2).to receive(:update).and_return(true)
			patch :update, {id: 2, user: {id: 2, email: 'janedoe@berkeley.edu'}}
			expect(response).to redirect_to(users_path)
		end

		it 'should render the edit template if update is not successful' do
			expect(User).to receive(:find).with("2").and_return(@user2)
			expect(@user2).to receive(:update).and_return(false)
			patch :update, {id: 2, user: {id: 2, email: 'janedoe@berkeley.edu'}}
			expect(response).to render_template :edit
		end
	end

	describe 'DELETE destroy' do
		before :each do
			@user1 = User.create(id: 1, name: 'John Doe', email: 'jdoe@berkeley.edu', auth: true, admin: true)
			@user2 = User.create(id: 2, name: 'Jane Doe', email: 'jdoe2@berkeley.edu', auth: true, admin: false)
			session[:user_id] = 1
			expect(User).to receive(:find).with(1).and_return(@user1)
			expect(User).to receive(:find).with("2").and_return(@user2)
		end

		it 'should assign @users' do
			delete :destroy, {id: 2, user: {id: 2}}
			expect(assigns(:user)).not_to be_nil
			expect(assigns(:user)).to eq(@user2)
		end

		it 'should call User#destroy' do
			expect(@user2).to receive(:destroy)
			delete :destroy, {id: 2, user: {id: 2}}
		end

		it 'should redirect to the users page' do
			delete :destroy, {id: 2, user: {id: 2}}
			expect(response).to redirect_to users_path
		end

		it 'should flash a success message' do
			delete :destroy, {id: 2, user: {id: 2}}
			expect(response.request.flash.notice).to eq("User was successfully destroyed.")
		end
	end
end
