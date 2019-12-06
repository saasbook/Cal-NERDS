require 'rails_helper'

RSpec.describe SchedulesController, type: :controller do

	before :each do
		@admin = User.create(id: 1, name: 'John Doe', email: 'jdoe@berkeley.edu', auth: true, admin: true)
		@auths = [
			User.create(id: 2, name: 'Jane Doe', email: 'jdoe2@berkeley.edu', auth: true, admin: false),
			User.create(id: 3, name: 'Jane Doe 2', email: 'jdoe3@berkeley.edu', auth: true, admin: false),
			User.create(id: 4, name: 'Jane Doe 3', email: 'jdoe4@berkeley.edu', auth: true, admin: false),
			User.create(id: 5, name: 'Jane Doe 4', email: 'jdoe5@berkeley.edu', auth: true, admin: false),
		]
		@unauth = User.create(id: 6, name: 'Jen Doe', email: 'jdoe3@berkeley.edu', auth: false, admin: false)
	end

	describe 'GET index' do

		before :each do
			Schedule.create!(id: 1, user_id: 2, start_date: Date.parse('2019-12-02').to_datetime, 
				mon_times: "[1000, 1030, 1100, 1130]")
		end

		it 'should assign @this_monday' do
			get :index, {schedule_start_date: '2019-12-02', user_id: 2}
			expect(assigns(:this_monday)).not_to be_nil
			expect(assigns(:this_monday)).to eq(Date.parse('2019-12-02'))
		end

		it 'should redirect if no user supplied' do
			get :index, {schedule_start_date: '2019-12-02'}
			expect(response).to redirect_to root_path
		end
	end

	describe 'GET show' do 
		before :each do
			session[:user_id] = 2
			@sched = Schedule.create(id: 1, user_id: 2, mon_times: "[1000, 1030, 1100, 1130]")
			expect(Schedule).to receive(:find).with("1").and_return(@sched)
			expect(User).to receive(:find).with(2).and_return(@sched)
			expect(User).to receive(:find).with("2").and_return(@sched)
		end

		it 'should assign @times_hash' do
			get :show, {id: 1, user_id: 2, schedule: {user_id: 2, id: 1}}
			expect(assigns(:times_hash)).not_to be_nil
			expect(assigns(:times_hash)).to eq({
				mon_times: [1000, 1030, 1100, 1130],
				tue_times: [],
				wed_times: [],
				thu_times: [],
				fri_times: [],
				mon_var_times: [],
				tue_var_times: [],
				wed_var_times: [],
				thu_var_times: [],
				fri_var_times: []
			})
		end
	end

	describe 'GET new' do
		it 'should assign @schedule' do
			get :new, {user_id: 2}
			expect(assigns(:schedule)).not_to be_nil
			expect(assigns(:schedule).class).to eq(Schedule)
		end
	end

	describe 'GET edit' do
		before :each do
			session[:user_id] = 3
			@sched = Schedule.create(id: 1, user_id: 3, mon_times: "[1000, 1030, 1100, 1130]")
		end

		it 'should assign @times_hash' do
			get :edit, {id: 1, user_id: 3}
			expect(assigns(:times_hash)).not_to be_nil
			expect(assigns(:times_hash)).to eq({
				mon_times: [1000, 1030, 1100, 1130],
				tue_times: [],
				wed_times: [],
				thu_times: [],
				fri_times: [],
				mon_var_times: [],
				tue_var_times: [],
				wed_var_times: [],
				thu_var_times: [],
				fri_var_times: []
			})
		end
	end

	describe 'POST create' do
		before :each do
			session[:user_id] = 3
			expect(User).to receive(:find).with(3).and_return(@auths[1])
		end

		it 'should redirect if start date already exists' do
			expect(User).to receive(:find).with('3').and_return(@auths[1])
			Schedule.create(id: 1, user_id: 3, start_date: Date.parse('2019-12-02').to_datetime)
			post :create, {user_id: 3, schedule: {start_date: '2019-12-02'}}
			expect(response).to redirect_to edit_user_schedule_path(3, 1)
		end

		it 'should redirect if start_date is not a monday' do
			expect(User).to receive(:find).with('3').and_return(@auths[1])
			post :create, {user_id: 3, schedule: {start_date: '2019-12-03'}}
			expect(response).to redirect_to new_user_schedule_path 3
		end

		it 'should assign @schedule' do
			expect(User).to receive(:find).with("3").and_return(@auths[1])
			expect(User).to receive(:find).with("3").and_return(@auths[1])
			post :create, {user_id: 3, schedule: {mon_times: "[1000, 1030]", start_date: "2019-12-02"}}
			expect(assigns(:schedule)).not_to be_nil
			expect(assigns(:schedule).class).to eq(Schedule)
		end

		it 'should redirect to index page if successful' do
			expect(User).to receive(:find).with("3").and_return(@auths[1])
			expect(User).to receive(:find).with("3").and_return(@auths[1])
			expect_any_instance_of(Schedule).to receive(:save).and_return(true)
			post :create, {user_id: 3, schedule: {mon_times: "[1000, 1030]", start_date: "2019-12-02"}}
			expect(response).to redirect_to(user_schedules_path @auths[1])
		end

		it 'should render the new template if unsuccessful' do
			expect(User).to receive(:find).with("3").and_return(@auths[1])
			expect_any_instance_of(Schedule).to receive(:save).and_return(false)
			post :create, {user_id: 3, schedule: {mon_times: "[1000, 1030]", start_date: "2019-12-02"}}
			expect(response).to render_template(:new)
		end
	end

	describe 'PATCH update' do
		before :each do
			session[:user_id] = 3
			@sched = Schedule.create(id: 1, user_id: 3, mon_times: "[1000, 1030, 1100, 1130]")
		end

		it 'should assign @schedule' do
			patch :update, {id: 1, user_id: 3, schedule: {tue_times: "[1000, 1030]"}}
			expect(assigns(:schedule)).not_to be_nil
			expect(assigns(:schedule).class).to eq(Schedule)
		end

		it 'should redirect to the schedule page if successful' do
			expect_any_instance_of(Schedule).to receive(:update).and_return(true)
			patch :update, {id: 1, user_id: 3, schedule: {tue_times: "[1000, 1030]"}}
			expect(response).to redirect_to(user_schedule_path(@auths[1], @sched))
		end

		it 'should render the edit template if unsuccessful' do
			expect_any_instance_of(Schedule).to receive(:update).and_return(false)
			patch :update, {id: 1, user_id: 3, schedule: {tue_times: "[1000, 1030]"}}
			expect(response).to render_template :edit
		end
	end

	describe 'DELETE destroy' do
		before :each do
			session[:user_id] = 3
			@sched1 = Schedule.create(id: 1, user_id: 3, mon_times: "[1000, 1030, 1100, 1130]")
			@sched2 = Schedule.create(id: 2, user_id: 4, mon_times: "[1000, 1030, 1100, 1130]")
		end

		it 'should assign @schedule' do
			delete :destroy, {id: 2, user_id: 4}
			expect(assigns(:schedule)).not_to be_nil
			expect(assigns(:schedule).class).to eq(Schedule)
			expect(assigns(:schedule)).to eq(@sched2)
		end

		it 'should redirect to the index page' do
			delete :destroy, {id: 2, user_id: 4}
			expect(response).to redirect_to(user_schedules_path @auths[2])
		end
	end
end
