# frozen_string_literal: true

module Api
  module V1
    class MemberProjectsController < Api::V1::BaseController
      def create
        @member_project = MemberProject.create!(member_project_params)
        render 'create', status: :created
      end

      private

      def member_project_params
        params.require(:member_project).permit(:member_id, :project_id)
      end
    end
  end
end
