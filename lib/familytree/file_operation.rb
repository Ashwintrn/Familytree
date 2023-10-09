require "json"

module FileOperation
  class << self
    FILE_NAME = 'familytree_storage.json'

    def put_into_file(obj)
      content = read_from_file
      content = create_content_for_file(obj, content)
      write_to_file(content)
    end

    def read_from_file
      if File.exist?(FILE_NAME)
        content = (file = File.read(FILE_NAME)).empty? ? {} : JSON.parse(file)
      end
    end

    def create_content_for_file(obj, content)
      if content[obj.class.to_s].is_a?(Array)
        content[obj.class.to_s] << form_param(obj)
      else
        content[obj.class.to_s] = [form_param(obj)]
      end
      JSON.dump(content)
    end

    def form_param(obj)
      case obj.class.to_s 
      when "Person"
        {"name": obj.name, "gender": obj.gender}
      when "Relationship"
        {"relation": obj.relation}
      when "Connection"
        {"person1": obj.person1, "type": obj.type, "person2": obj.person2}
      end
    end

    def write_to_file(content)
      file = File.open(FILE_NAME, "w+")
      file.write(content)
      file.close
    end

  end 
end