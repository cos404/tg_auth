class User
  include Mongoid::Document

  field :_id, type: Integer
  field :first_name, type: String
  field :last_name, type: String
  field :username, type: String
  field :language_code, type: String
  field :token, type: String

end