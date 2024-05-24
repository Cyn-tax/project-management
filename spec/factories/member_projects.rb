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
FactoryBot.define do
  factory :member_project do
    association :member
    association :project
  end
end
