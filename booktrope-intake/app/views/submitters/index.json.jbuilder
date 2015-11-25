json.array!(@submitters) do |submitter|
  json.extract! submitter, :id, :first_name, :last_name, :email, :phone_location_id, :phone_number, :country, :pen_name_first, :pen_name_last
  json.url submitter_url(submitter, format: :json)
end
