# frozen_string_literal: true

json.set! :teams do
  json.array! @teams do |team|
    json.partial! 'team', team:
  end
end
