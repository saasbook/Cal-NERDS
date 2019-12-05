class SchedulesController < ApplicationController
  before_action :set_current_user, :set_user
  before_action :check_user_permissions
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  # GET /schedules
  # GET /schedules.json
  def index
    @schedules = Schedule.all
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
    @times_hash = Schedule.parse_times_strings @schedule
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
    @times_hash = Schedule.parse_times_strings @schedule
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)
    respond_to do |format|
      if @schedule.save
        ScheduleMailer.schedule_email(@schedule.user).deliver_later
        format.html { redirect_to user_schedules_path, notice: 'Schedule was successfully created.' }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    respond_to do |format|

      this_schedule_params = schedule_params()

      for day in ["mon", "tue", "wed", "thu", "fri"]
        if this_schedule_params[day + "_times"].nil?
          this_schedule_params[day + "_times"] = []
        end
        if this_schedule_params[day + "_var_times"].nil?
          this_schedule_params[day + "_var_times"] = []
        end
      end

      if @schedule.update(this_schedule_params)
        format.html { redirect_to user_schedule_path, notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to user_schedules_url, notice: 'Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # GET /schedules/overview
  def overview
    @schedules = Schedule.all
    @users = User.all.order(:name)
    @user_time_hash = Hash.new
    for user in @users
     times_hash = Schedule.get_user_time_strings user
     if times_hash.nil?
      @user_time_hash[user.id] = Hash.new []
     else
       @user_time_hash[user.id] = times_hash
     end
    end
    
    if Schedule.has_no_schedules
      flash[:notice] = "No schedules have been added."
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def set_user
      if !params[:user_id].nil?
        @user = User.find(params[:user_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # :start_date has been taken out for testing purpose. REMEMBER to put it back in!!!!!!!!!!
    def schedule_params
      if params[:schedule].nil?
        params[:schedule] = {
          mon_times: [],
          tue_times: [],
          wed_times: [],
          thu_times: [],
          fri_times: []
        }
      end
      params[:schedule][:user_id] = params[:user_id]
      params.require(:schedule).permit(:user_id, :start_date, :mon_times => [], :tue_times => [], :wed_times => [],
        :thu_times => [], :fri_times => [], :mon_var_times => [], :tue_var_times => [], :wed_var_times => [],
        :thu_var_times => [], :fri_var_times => [])
    end

    def check_user_permissions
      if !@current_user.admin && !params[:user_id].nil? && @current_user.id != params[:user_id].to_i
        redirect_to root_path, notice: 'You are not authorized to access this page.'
      elsif params[:user_id].nil? && !@current_user.admin
        redirect_to root_path, notice: 'You are not authorized to access this page.'
      end
    end
end
