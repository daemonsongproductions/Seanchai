class PseudoUser < User

  def after_initialize
    self.id = -1
    self.user_type = UserType.reader
  end


end