class TasksController < ApplicationController
 before_action :set_task,only:[:show,:edit,:update,:destroy]
 
 
  def index
    if (logged_in?)
     @tasks = current_user.tasks.page(params[:page])
    end
  end
  
  def show
  end
  
  def  new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Taskが正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが投稿されませんでした'
      render :new
    end
    
      
  end

  def edit
  end

  def update
   
    
    if @task.update(task_params)
      flash[:success] = 'Tsakは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to tasks_url
  end
private
def set_task
  #@task = Task.find(params[:id])
  
  @task = current_user.tasks.find_by(params[:id])
  if (@task == nil)
    redirect_to root_url
  end
end


def task_params
 params.require(:task).permit(:content,:status,:user_id)
end
end


