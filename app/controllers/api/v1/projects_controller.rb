# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < Api::V1::BaseController
      before_action :find_project, only: %i[show update destroy]

      def index
        @projects = Project.all
      end

      def show; end

      def create
        @project = Project.create!(project_params)
        render 'create', status: :created
      end

      def update
        @project.update!(project_params)
      end

      def destroy
        @project.destroy
        head :no_content
      end

      private

      def find_project
        @project = Project.find(params[:id])
      end

      def project_params
        params.require(:project).permit(:name)
      end
    end
  end
end
