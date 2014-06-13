json.array!(@people) do |person|
  json.extract! person, :id, :lastname, :firstname, :email, :dateofbirth, :private_phone, :professional_phone
  json.url person_url(person, format: :json)
end
