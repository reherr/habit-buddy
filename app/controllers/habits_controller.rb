class HabitsController < ApplicationController
  before_action :set_habit, only: %i[show edit update destroy]
  before_action { authorize(@habit || Habit ) }

  # GET /habits or /habits.json
  def index
    @habits = policy_scope(Habit)
  end

  # GET /habits/1 or /habits/1.json
  def show
    # for Ransack
    @habit = Habit.find(params[:id])
    @q = @habit.habit_entries.ransack(params[:q])
    @habit_entries = @q.result.order(entry_date: :asc).page(params[:page]).per(3)

    # for Chartkick
    completed_count = @habit.habit_entries.where(status: true).count
    total_count = @habit.habit_entries.count
    not_completed_count = total_count - completed_count

    @completion_rate = {
      "Completed (#{(completed_count.to_f / total_count * 100).round(2)}%)" => completed_count,
      "Not Completed (#{(not_completed_count.to_f / total_count * 100).round(2)}%)" => not_completed_count
    }

    @breadcrumbs = [
      { content: 'Habits', href: habits_path },
      { content: @habit.name, href: habit_path(@habit) }
    ]
    respond_to do |format|
      format.html { render :show }
      format.js
    end
  end

  # GET /habits/new
  def new
    @habit = Habit.new

    @breadcrumbs = [
      { content: 'Habits', href: habits_path },
      { content: 'New' }
    ]
  end

  # GET /habits/1/edit
  def edit
    @habit = Habit.find(params[:id])

    @breadcrumbs = [
      { content: 'Habits', href: habits_path },
      { content: @habit.name, href: habit_path(@habit) },
      { content: 'Edit' }
    ]
  end

  # POST /habits or /habits.json
  def create
    @habit = Habit.new(habit_params)

    respond_to do |format|
      if @habit.save
        format.html { redirect_to habit_url(@habit), notice: 'Habit was successfully created.' }
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
        format.html { redirect_to habit_url(@habit), notice: 'Habit was successfully updated.' }
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
      format.html { redirect_to habits_url, notice: 'Habit was successfully destroyed.' }
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
