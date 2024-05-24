# frozen_string_literal: true

# == Schema Information
#
# Table name: member_projects
#
#  id         :bigint           not null, primary key
#  member_id  :bigint           not null
#  project_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class MemberProject < ApplicationRecord
  belongs_to :member
  belongs_to :project

  validates :member_id, uniqueness: { scope: :project_id }
end
