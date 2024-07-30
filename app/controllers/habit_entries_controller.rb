class HabitEntriesController < ApplicationController
  before_action :set_habit_entry, only: %i[ show edit update destroy ]

  # GET /habit_entries or /habit_entries.json
  def index
    @habit_entries = HabitEntry.all
    @habit = Habit.all.sample
  end

  # GET /habit_entries/1 or /habit_entries/1.json
  def show
    habit_id = @habit_entry.habit_id
    @habit = Habit.where({ :id => habit_id }).first
  end

  # GET /habit_entries/new
  def new
    # @habit_entry = HabitEntry.new
    # habit_id = params.fetch("habit_id")
    @habit_id = params[:habit_id]
    @habit_entry = HabitEntry.new(habit_id: @habit_id)
    @habit = Habit.where({ :id => @habit_id }).first
  end

  # GET /habit_entries/1/edit
  def edit
    habit_id = @habit_entry.habit_id
    @habit = Habit.where({ :id => habit_id }).first
  end

  # POST /habit_entries or /habit_entries.json
  def create
    habit_id = params.fetch("habit_entry").fetch("habit_id")
    @habit = Habit.where({ :id => habit_id }).first
    @habit_entry = HabitEntry.new(habit_entry_params)

      respond_to do |format|
      if @habit_entry.save
        format.html { redirect_to habit_entry_url(@habit_entry), notice: "Nice! Keep it up." }
        format.json { render :show, status: :created, location: @habit_entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @habit_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /habit_entries/1 or /habit_entries/1.json
  def update
    @habit_entry = HabitEntry.find(params[:id])

    respond_to do |format|
      if @habit_entry.update(habit_entry_params)
        format.html { redirect_to habit_entry_url(@habit_entry), notice: "Habit entry was successfully updated." }
        format.json { render :show, status: :ok, location: @habit_entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @habit_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /habit_entries/1 or /habit_entries/1.json
  def destroy
    @habit_entry.destroy!

    respond_to do |format|
      format.html { redirect_to habit_entries_url, notice: "Habit entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_habit_entry
      @habit_entry = HabitEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def habit_entry_params
      params.require(:habit_entry).permit(:user_id, :habit_id, :entry_date, :status, :note)
    end
end
