# frozen_string_literal: true

module Api
  module V1
    module Teams
      class MembersController < Api::V1::BaseController
        def index
          @members = Team.find(params[:team_id]).members
        end
      end
    end
  end
end
