# frozen_string_literal: true

require_relative "familytree/version"
require_relative "familytree/strategy"
require_relative "familytree/file_operation"

module Familytree

  class Error < StandardError; end
  
  def self.add_person(name, gender)
    person = Person.new(name, gender)
    FileOperation.put_into_file(person)
  end

  def self.add_relation(relationship)
    relationship = Relationship.new(relationship)
    FileOperation.put_into_file(relationship)
  end

  def self.connect(name1, relationship, name2)
    fetch_all
    person1 = @people.find { |person| person["name"] == name1 }
    person2 = @people.find { |person| person["name"] == name2 }
    relationship = @relationships.find { |r| r["relation"] == relationship }

    if person1 && person2 && relationship
      connection = Connection.new(person1, relationship, person2)
      FileOperation.put_into_file(connection)
    else
      puts "Error: Invalid input"
    end
  end

  def self.fetch_all
    fetch_people
    fetch_relationship
    fetch_connection
  end

  def self.fetch_people
    content = FileOperation.read_from_file
    @people = content["Person"] if content
  end

  def self.fetch_relationship
    content = FileOperation.read_from_file
    @relationships = content["Relationship"] if content
  end

  def self.fetch_connection
    content = FileOperation.read_from_file
    @connections = content["Connection"] if content
  end

  def self.count_relationship(name, relationship_type)
    fetch_all
    person = @people.find { |p| p["name"] == name }
    return unless person

    case relationship_type
    when "sons"
      sons = @connections.select { |r| (r["type"]["relation"] == "son" && r["person2"]["name"] == name) || (r["type"]["relation"] == "father" && r["person1"]["name"] == name && r["person2"]["gender"] == 'male') }
      puts "Number of sons of #{name}: #{sons.length}"
    when "daughters"
      daughters = @connections.select { |r| (r["type"]["relation"] == "daughter" && r["person2"]["name"] == name) || (r["type"]["relation"] == "father" && r["person1"]["name"] == name && r["person2"]["gender"] == 'female') }
      puts "Number of daughters of #{name}: #{daughters.length}"
    when "wives"
      wives = @connections.select { |r| r["type"]["relation"] == "wife" &&  r["person2"]["name"] == name }
      puts "Number of wives of #{name}: #{wives.length}"
    when "father"
      father_relation = @connections.find { |r| r["type"]["relation"] == "son" && r["person2"]["name"] == name &&r["person2"]["gender"] == 'male' }
      puts "Father of #{name}: #{father_relation.person1.name}" if father_relation
    else
      puts "Error: Invalid relationship type"
    end
  end

  def self.display
    p "inside display"
    fetch_people
    p @people
    @people.each do |p|
      puts "p1: #{p["name"]}, gender: #{p["gender"]}, p2: c.person2.name}"
    end 
    puts "nothing"
  end

end
