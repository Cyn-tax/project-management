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
require 'rails_helper'

RSpec.describe MemberProject, type: :model do
  describe 'associations' do
    it { should belong_to(:member) }
    it { should belong_to(:project) }
  end
end
