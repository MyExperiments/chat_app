#
# ApplicationHelper
#
# @author sufinsha
#
module ApplicationHelper
  # To convet nil values to empty string
  #
  # @param object nil|Hash|string|Array
  #
  # @return converted value
  def convert_nil_to_empty_string(object)
    return object.to_s if object.nil?
    if object.is_a?(Hash)
      object.each do |key, val|
        object[key] = convert_nil_to_empty_string(val)
      end
    elsif object.is_a?(Array)
      object.each_with_index do |val, index|
        object[index] = convert_nil_to_empty_string(val)
      end
    end
    object
  end
end
