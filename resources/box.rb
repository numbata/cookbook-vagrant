actions :install

attribute :name, :kind_of => String, :name_attribute => true

default_action :install

def initialize(*args)
  super
  @action = :install
end
