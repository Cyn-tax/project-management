# frozen_string_literal: true

module Api
  module V1
    class TeamsController < Api::V1::BaseController
      before_action :find_team, only: %i[show update destroy]

      def index
        @teams = Team.all
      end

      def show; end

      def create
        @team = Team.create!(team_params)
        render 'create', status: :created
      end

      def update
        @team.update!(team_params)
      end

      def destroy
        @team.destroy
        head :no_content
      end

      private

      def find_team
        @team = Team.find(params[:id])
      end

      def team_params
        params.require(:team).permit(:name)
      end
    end
  end
end
