# frozen_string_literal: true

# == Schema Information
#
# Table name: members
#
#  id         :bigint           not null, primary key
#  first_name :string           not null
#  last_name  :string           not null
#  city       :string
#  state      :string
#  country    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint
#
class Member < ApplicationRecord
  has_many :member_projects, dependent: :nullify
  has_many :projects, through: :member_projects
  belongs_to :team

  validates :first_name, presence: true
  validates :last_name, presence: true
end
