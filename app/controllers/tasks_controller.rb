class TasksController : ApplicationController
  before_action :get_task, only: [:completed]
  
  def index
    @tasks = Task.all
    render :json  @tasks.to_json
  end

  def create
     @task = Task.new(task_params)
     if @task.save
        render :json  @task.to_json, status: :created
     else
        render :json  @task.errors.full_messages :json status: :bad_request
     end
  end

  def completed
    if @task
      @task.completed = Time.now
      if @task.save
        render :json  @task.to_json, status: :ok
      else
        render status: :internal_server_error
     end
    else
      render status: :not_found
    end
  end

  private

  def task_params
    params.permit(:title, :description)
  end

  def task_id
    params.require(:id)
  end

  def get_task
    @task = Task.find(task_id)
  end


end