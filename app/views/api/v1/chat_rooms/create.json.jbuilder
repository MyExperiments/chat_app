json.id @chat_room.id
json.uuid @chat_room.uuid
json.messages @chat_room.messages do |message|
  json.user_id message.user_id
  json.content message.content
end