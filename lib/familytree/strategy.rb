require_relative "file_operation"

#Defines person info and also to identify the gender
class Person
  include FileOperation
  attr_accessor :name, :gender

  def initialize(name, gender)
    @name = name
    @gender = gender
    puts "------- added Person: #{@name} ------ "
  end
end

#Collects the different relation types like son, daughter
class Relationship
  include FileOperation
  attr_accessor :relation

  def initialize(relation)
    @relation = relation
    puts "------- added relationship: #{@relation} ------ "
  end
end

#Connects the relationship type for Person1 to Person2
class Connection
  include FileOperation
  attr_accessor :person1, :type, :person2

  def initialize(person1_name, type, person2_name)
    @person1 = person1_name
    @type = type #only the relationship is stored and not the relation object
    @person2 = person2_name
    puts "------- added connection: #{@person1} as #{@type} of #{@person2} ------ "
  end
end

# def display_connections
#   connections.each do |c|
#     puts "p1: #{c.person1.name}, type: #{c.type}, p2: #{c.person2.name}"
#   end
# end
