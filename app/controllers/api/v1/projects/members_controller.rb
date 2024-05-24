# frozen_string_literal: true

module Api
  module V1
    module Projects
      class MembersController < Api::V1::BaseController
        def index
          @members = Project.find(params[:project_id]).members
        end
      end
    end
  end
end
