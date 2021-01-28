class SchedulesController < ApplicationController
  before_action :set_current_user, :set_user
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

      for day in ["mon_times", "tue_times", "wed_times", "thu_times", "fri_times"]
        if this_schedule_params[day].nil?
          this_schedule_params[day] = []
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
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
        :thu_times => [], :fri_times => [])
    end
end
