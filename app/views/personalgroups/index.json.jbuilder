json.array!(@personalgroups) do |personalgroup|
  json.extract! personalgroup, :id, :person_id
  json.url personalgroup_url(personalgroup, format: :json)
end
