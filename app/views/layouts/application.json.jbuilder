json.success @success
json.message @message

json.merge! convert_nil_to_empty_string(JSON.parse(yield))
