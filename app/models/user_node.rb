#
# UserModel
#
# @author UserNode
#
class UserNode
  include Neo4j::ActiveNode
  property :name, type: String
  property :user_id, type: Integer

  has_many :both, :friends, type: :friend, model_class: :UserNode, unique: true
  has_many :in, :friend_requests, type: :friend_request, model_class: :UserNode, unique: true
end
