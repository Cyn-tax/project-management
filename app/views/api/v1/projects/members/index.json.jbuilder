# frozen_string_literal: true

json.set! :members do
  json.array! @members do |member|
    json.partial! '/shared/partials/member', member:
  end
end
