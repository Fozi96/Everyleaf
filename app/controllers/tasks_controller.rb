class TasksController < ApplicationController
  class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def new
    @task = Task.new
  end

  def index
    @search = Task.ransack(params[:q])
    if params[:q]
      @tasks = @search.result.page params[:page]
    elsif params[:search_label]
    @tasks = Task.joins(:labels)
        .where("labels.name ILIKE ?", "%#{params[:search_label]}%").page params[:page]
    elsif params[:sort_deadline]
      @tasks = Task.all.order('end_at DESC').page params[:page]
    elsif params[:sort_priority]
      @tasks = Task.all.order('priority DESC').page params[:page]
    else
      @tasks = Task.all.order('created_at DESC').page params[:page]
    end
  end

  def show
  end


  def edit
  end

  def create
    tasks = Task.all
    @task = tasks.build(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # @task = tasks(task_params)
    # tasks = Task.all
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :content, :status, :priority, :start_at, :end_at)
    end
end
end
