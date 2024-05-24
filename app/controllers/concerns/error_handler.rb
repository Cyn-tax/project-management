# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from UnprocessableEntity, with: :unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActionController::ParameterMissing, with: :bad_request
  end

  private

  def unprocessable_entity(error)
    render json: { error: { message: error.message } }, status: :unprocessable_entity
  end

  def not_found(_error)
    render json: { error: { message: 'Not found' } }, status: :not_found
  end

  def bad_request(_error)
    render json: { error: { message: 'Bad request' } }, status: :bad_request
  end

  class UnprocessableEntity < StandardError; end
end
