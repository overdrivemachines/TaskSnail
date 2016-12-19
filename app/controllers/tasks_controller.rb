class TasksController < ApplicationController
	before_action :set_task, only: [:edit, :update, :destroy]

	respond_to :html
	respond_to :js

	# GET /tasks
	def index
		# Display tasks created by current_user
		@user = current_user
		if @user.soft_user?
			@tasks = Task.where(soft_token: @user.soft_token)
		else
			@tasks = @user.tasks.all
		end
		respond_with(@tasks)
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
		@user = current_user
		@task = Task.new(task_params)

		if @user.soft_user?
			@task.soft_token = @user.soft_token
		end

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
		@task.mark_complete!
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_task
			@task = Task.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def task_params
			params.require(:task).permit(:name, :complete, :user_id)
		end
end
