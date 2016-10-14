require "rexml/document"
include REXML

## Get file and parse it
puts "Please enter the absolute path of the XML file you would like to manipulate..."
xml_path = gets.chomp
file = File.new(xml_path)
document = Document.new file

## Get root
root = document.root
puts "\n Waiting at root node called #{root.name}"
current_node = root
on = true

## Loop through the program until asked to quit

while on == true
	puts "\n What would you like me to do?\n"
	puts "\n'child n' will take you down the tree n times"
	puts "'Show' will list the node type and the text content"
	puts "'Attributes' will list the attribute and value for the current node"
	puts "'Next' will take you into the next sibling element"
	puts "'Back' will take you into the previous sibling element"
	puts "'Quit' will exit the program"

	print "\n >"
	command = gets.chomp.downcase
	
	case command
		when /^child/
			traverse = command.tr("^0-9", '')
			if current_node.elements[traverse.to_i]
			current_node = current_node.elements[traverse.to_i]
			#add in error checking to go back to root if no children exist
			puts "I am now in #{current_node.name}"	
			else
				puts "You're trying to access a node at a deeper level than exists. Please try again"
			end
			
		when "show"
			puts "Type: #{current_node.node_type}"
			if current_node.attributes['name']
				puts "Name: #{current_node.attributes['name']}"
			end
			
			if current_node.text
				puts "Text Content: #{current_node.text}"
			end
			
			
		when "attributes"
				puts current_node.attributes.map {|e, v| puts "#{e}: #{v}"}

		when "up"
			if current_node != root
				current_node = current_node.parent
				puts "You are now in #{current_node.name}"
			else
				puts "already at root!"
			end
		
		when "next"
			if current_node.next_element.nil?
				puts "No subsiquent siblings!"
			else 
				current_node = current_node.next_element
				puts "You are now in #{current_node.name}"
			end

		when "back"
		if current_node.previous_element.nil?
			puts "No siblings exist before this node"
		else 
			current_node = current_node.previous_element
			puts "You are now in #{current_node.name}"
		end
		
		when "quit"
			puts "See you next time"
		on = false;
	end
	
end		
	
			
