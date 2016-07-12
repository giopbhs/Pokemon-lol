json.array!(@coments) do |coment|
  json.extract! coment, :id, :pin_id, :body, :user_id
  json.url coment_url(coment, format: :json)
end
