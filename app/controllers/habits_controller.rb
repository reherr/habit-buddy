class HabitsController < ApplicationController
  before_action :set_habit, only: %i[ show edit update destroy ]

  # GET /habits or /habits.json
  def index
    user_id = current_user.id
    @habits = Habit.where(user_id: user_id).all
    # @habits = current_user.habits
  end

  # GET /habits/1 or /habits/1.json
  def show
    @habit = Habit.find(params[:id])
    @q = @habit.habit_entries.ransack(params[:q])
    @habit_entries = @q.result
  end

  # GET /habits/new
  def new
    @habit = Habit.new
  end

  # GET /habits/1/edit
  def edit
    @habit = Habit.find(params[:id])
  end

  # POST /habits or /habits.json
  def create
    @habit = Habit.new(habit_params)

    respond_to do |format|
      if @habit.save
        format.html { redirect_to habit_url(@habit), notice: "Habit was successfully created." }
        format.json { render :show, status: :created, location: @habit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @habit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /habits/1 or /habits/1.json
  def update
    respond_to do |format|
      if @habit.update(habit_params)
        format.html { redirect_to habit_url(@habit), notice: "Habit was successfully updated." }
        format.json { render :show, status: :ok, location: @habit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @habit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /habits/1 or /habits/1.json
  def destroy
    @habit.destroy!

    respond_to do |format|
      format.html { redirect_to habits_url, notice: "Habit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_habit
      @habit = Habit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def habit_params
      params.require(:habit).permit(:name, :description, :start_date, :end_date, :user_id)
    end
end
