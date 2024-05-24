# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Project < ApplicationRecord
  validates :name, presence: true
  has_many :member_projects, dependent: :nullify
  has_many :members, through: :member_projects
end
