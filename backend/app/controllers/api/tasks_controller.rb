# app/controllers/api/tasks_controller.rb
module Api
  class TasksController < ApplicationController
    before_action :set_task, only: [:destroy]
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActionController::ParameterMissing, with: :parameter_missing
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

    # GET /api/tasks
    def index
      @tasks = Task.all
      render json: @tasks
    end

    # POST /api/tasks
    def create
      @task = Task.new(task_params)

      if @task.save
        render json: @task, status: :created, location: api_task_url(@task)
      else
        render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /api/tasks/:id
    def destroy
      @task.destroy
      head :no_content
    end

    private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :completed)
    end

    # Error handling methods
    def not_found
      render json: { error: "Task not found" }, status: :not_found
    end

    def parameter_missing(exception)
      render json: { error: exception.message }, status: :bad_request
    end

    def unprocessable_entity(exception)
      render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
  end
end