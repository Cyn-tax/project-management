# frozen_string_literal: true

json.set! :projects do
  json.array! @projects do |project|
    json.partial! 'project', project:
  end
end
