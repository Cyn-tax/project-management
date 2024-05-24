# frozen_string_literal: true

module Api
  module V1
    class MembersController < Api::V1::BaseController
      before_action :find_member, only: %i[show update destroy]

      def index
        @members = Member.all
      end

      def show; end

      def create
        @member = Member.create!(member_params)
        render 'create', status: :created
      end

      def update
        @member.update!(member_params)
      end

      def destroy
        @member.destroy
        head :no_content
      end

      private

      def find_member
        @member = Member.find(params[:id])
      end

      def member_params
        params.require(:member).permit(:first_name, :last_name, :city, :state, :country, :team_id)
      end
    end
  end
end
