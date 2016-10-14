require "rexml/document"
include REXML


puts "Please enter the location of the XML file you would like to manipulate..."
xml_path = gets.chomp
file = File.new(xml_path)
document = Document.new file

root = document.root
puts "Waiting at root node #{root.name}"
current_node = root
on = true

while on == true
	puts "What would you like me to do?"
	command = gets.chomp.downcase
	case command
		when /^child/
			traverse = command.tr("^0-9", '')
			current_node = current_node.elements[traverse.to_i]
			#add in error checking to go back to root if no children exist
			puts "I am now in #{current_node.name}"	
			
		when "show"
			puts "Type: #{current_node.node_type}"
			if current_node.attributes['name']
				puts "Name: #{current_node.attributes['name']}"
			end
			
			if current_node.text
				puts "Text Content: #{current_node.text}"
			end
			
			all_children = current_node.to_a
			all_children.each do |a|
				puts a
			end
			
		when "attributes"
			if current_node.attr
			puts current_node.attributes.map {|e, v| puts "#{e}: #{v}"}
	
		when "quit"
			puts "See you next time"
		break;
	end
	
end		
	
			
