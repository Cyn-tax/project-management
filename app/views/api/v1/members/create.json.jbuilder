# frozen_string_literal: true

json.set! :member do
  json.partial! '/shared/partials/member', member: @member
end
