class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def index
    @goals = Goal.users_visible_goals(current_user)
  end

  def show
    @goal = Goal.find_by_id(params[:id])
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find_by_id(params[:id])
  end

  def update
    @goal = Goal.find_by_id(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find_by_id(params[:id])
    @goal.destroy
    redirect_to goals_url
  end

  private

  def goal_params
    self.params.require(:goal).permit(:description, :privacy_status, :completion_status)
  end
end
