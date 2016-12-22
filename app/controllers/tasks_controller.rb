class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]

  # http://edgeapi.rubyonrails.org/classes/ActionController/Responder.html
  respond_to :html
  respond_to :js

  # GET /tasks
  def index
    @complete_tasks = Task.complete
    @incomplete_tasks = Task.incomplete
  end

  # GET /tasks/new
  def new
    @task = Task.new
    respond_with(@task)
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    @task.completed = false
    @task.save
    respond_with(@task)
  end

  # PATCH/PUT /tasks/1
  def update
    @task.update(task_params)
    respond_with(@task)
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    respond_with(@task)
  end

  def complete
    @task = Task.find(params[:id])
    @task.completed = true
    @task.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      # params.require(:task).permit(:name, :completed, :user_id)
      params.require(:task).permit(:name)
    end
end
