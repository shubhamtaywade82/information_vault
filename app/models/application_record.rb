# Parent Class to all the models Defined in the application
class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

end
