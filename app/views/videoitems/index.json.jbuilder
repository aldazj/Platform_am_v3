json.array!(@videoitems) do |videoitem|
  json.extract! videoitem, :id, :title, :description, :is_available, :date, :views, :pathvideo
  json.url videoitem_url(videoitem, format: :json)
end
