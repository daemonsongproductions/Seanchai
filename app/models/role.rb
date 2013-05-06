class Role
  include Mongoid::Document
  embeded_in :user
end