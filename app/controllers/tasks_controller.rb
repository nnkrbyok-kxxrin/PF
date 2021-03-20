class TasksController < ApplicationController

  def create
    @task_new = Task.new(task_params)
    @task_new.admin_id = current_admin.id
    @task_new.save
    redirect_to guests_path
  end

  def destroy
    # @task = Task.find(params[:id])
    # ログインしている人に基づくものしか表示させないため、上記を下記に変更
    @task = current_admin.tasks.find(params[:id])
    @task.destroy
    redirect_to guests_path
  end

  private

  def task_params
    params.require(:task).permit(:admin_id, :body)
  end

end