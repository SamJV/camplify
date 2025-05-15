class TasksController < ApplicationController
  before_action :set_task, only: [:completed]

  def index
    @tasks = Task.all
    render json: @tasks, status: :ok
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors.full_messages, status: :bad_request
    end
  end

  def completed
    if @task
      @task.completed_at = Time.now
      if @task.save
        render json: @task, status: :ok
      else
        render status: :internal_server_error
      end
    else
      render status: :not_found
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
