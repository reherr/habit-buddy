class HabitEntriesController < ApplicationController
  before_action :set_habit_entry, only: %i[show edit update destroy]
  before_action :authorize_habit_entry, only: %i[new create]

  # GET /habit_entries or /habit_entries.json
  def index
    @habit_entries = policy_scope(HabitEntry)
  end

  # GET /habit_entries/1 or /habit_entries/1.json
  def show
    @habit_entry = HabitEntry.find(params[:id])
    authorize @habit_entry
  end

  # GET /habit_entries/new
  def new
    @habit_id = params[:habit_id]
    @habit_entry = HabitEntry.new(habit_id: @habit_id)
    @habit = Habit.find(@habit_id)
    authorize @habit_entry

    @breadcrumbs = [
      { content: @habit.name, href: habit_path(@habit) },
      { content: 'New Habit Entry' }
    ]
  end

  # GET /habit_entries/1/edit
  def edit
    habit_id = @habit_entry.habit_id
    @habit = Habit.find(habit_id)
    authorize @habit_entry

    @breadcrumbs = [
      { content: @habit.name, href: habit_path(@habit) },
      { content: 'Edit' }
    ]
  end

  # POST /habit_entries or /habit_entries.json
  def create
    @habit_entry = HabitEntry.new(habit_entry_params)
    @habit = Habit.find(@habit_entry.habit_id)
    authorize @habit_entry

    respond_to do |format|
      if @habit_entry.save
        format.html { redirect_to habit_path(@habit_entry.habit), notice: 'Nice! Keep it up.' }
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
    authorize @habit_entry

    respond_to do |format|
      if @habit_entry.update(habit_entry_params)
        format.html { redirect_to habit_path(@habit_entry.habit), notice: 'Habit entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @habit_entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @habit_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /habit_entries/1 or /habit_entries/1.json
  def destroy
    authorize @habit_entry
    @habit_entry.destroy!

    respond_to do |format|
      format.html { redirect_to habit_entries_url, notice: 'Habit entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_habit_entry
    @habit_entry = HabitEntry.find(params[:id])
  end

  def authorize_habit_entry
    authorize @habit_entry || HabitEntry.new(habit_id: params[:habit_id])
  end

  def habit_entry_params
    params.require(:habit_entry).permit(:user_id, :habit_id, :entry_date, :status, :note)
  end
end
