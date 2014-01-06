module Seanchai
  module StatusMethods
    # Methods to be added to any model that saves a Status

    def status
      Status.find(status_id)
    end

    def status=(value)
      self.status_id = value.id
    end

  end
end