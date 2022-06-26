require_relative "list"
require "byebug"

class ToDoBoard
    def initialize(label)
        # @lista = List.new(label)

        @listas = {} # labels are k, List instances are v
    end

    def get_command
=begin
Possible commands:
mktodo <title> <deadline> <optional description>
makes a todo with the given information
up <index> <optional amount>
raises the todo up the list
down <index> <optional amount>
lowers the todo down the list
swap <index_1> <index_2>
swaps the position of todos
sort
sorts the todos by date
priority
prints the todo at the top of the list
print <optional index>
prints all todos if no index is provided
prints full information of the specified todo if an index is provided
quit
returns false

=end

        puts """

Welcome to the ToDoBoard!
------------------------------------------

mklist <label>
- makes a new list with label. Multi-word labels must be enclosed in \" \"

mktodo <list label> <title> <deadline> <optional description>
- makes a todo with the given information on the list with label <label>. Multi-word titles must be enclosed in \" \".

up <list label> <index> <optional amount>
- raises the todo up the list

down <list label> <index> <optional amount>
- lowers the todo down the list

swap <list label> <index_1> <index_2>
- swaps the position of todos

sort <list label>
- sorts the todos by date

priority <list label>
- prints the todo at the top of the list

print <list label> <optional index>
- prints all todos if no index is provided
- prints full information of the specified todo if an index is provided

toggle <list label> <index>
- Flips state of item's doneness between Done and Not Done

purge <list label>
- Delete all items that are marked as Done

rm <list label> <index>
- Removes item at index

quit
- returns false

Enter a command!
        """

# userinput.match(/^([a-z]+)(?:\s(\S+))?(?:\s(\S+))?(?:\s(.*+))?$/)


        userinput = gets.chomp

        usermatch = userinput.match(/^([a-z]+)(?:\s([^"]\S*|\"[^"]+\"))?(?:\s([^"]\S*|\"[^"]+\"))?(?:\s(\S+))?(?:\s(.*))?$/)

        raise RuntimeError.new("Invalid command!") if(!usermatch)

        cmd = usermatch[1]
        @lista = @listas[usermatch[2]]

        case cmd

        when 'mktodo'
            title = usermatch[3]
            deadline = usermatch[4]
            description = usermatch[5]

            @lista.add_item(title, deadline, description)
            puts "Added item #{title} with deadline #{deadline}: #{description}"

        when 'up'
            begin
                index = usermatch[3].to_i
                amount = [usermatch[4].to_i, 1].max # if nil, turns to 0
            rescue
                "Oops invalid arguments for up"
            else
                @lista.up(index, amount)
            end

        when 'down'
            begin
                index = usermatch[3].to_i
                amount = [usermatch[4].to_i, 1].max # if nil, turns to 0
            rescue
                "Oops invalid arguments for down"
            else
                @lista.down(index, amount)
            end

        when 'swap'
            begin
                index1 = usermatch[3].to_i
                index2 = usermatch[4].to_i
            rescue
                "Oops invalid arguments for swap"
            else
                @lista.swap(index1, index2)
            end

        when 'sort'
            @lista.sort_by_date!
            puts "List has been sorted."
        when 'priority'
            puts @lista.print_priority
        when 'print'
            if (usermatch[3])
                @lista.print_full_item(usermatch[3].to_i)
            else
                @lista.print
            end
        when 'toggle'
            @lista.toggle_item(usermatch[3].to_i)

        when 'rm'
            begin
                index = usermatch[3].to_i

            rescue
                "Oops invalid arguments for rm"
            else
                @lista.remove_item(index)
            end

        when 'purge'
            @lista.purge

        when 'ls'
            self.ls

        when 'mklist'
            puts "Creating list #{usermatch[2]}..."
            self.mklist(usermatch[2])

        when 'showall'
            self.showall

        when 'quit'

        else
            puts cmd
            raise RuntimeError.new("Invalid command")

        end

        if (cmd == 'quit')
            return false
        else
            puts "Press any key to continue"
            while gets.chomp == 'true'
            end
            return true
        end


    end

    def run
        keepgoing = true
        while(keepgoing)
            begin
                keepgoing = self.get_command
            rescue RuntimeError => err
                puts err.message
                retry
            end
        end

    end

    def mklist(label)
        @listas[label] = List.new(label)
    end

    def ls
        puts "Here are the lists created so far:"
        puts "----------------------------------"
        @listas.each_key { |label| puts label}
    end

    def showall
        puts "Printing all lists sequentially:"

        @listas.each_pair {|label, lista| lista.print}
    end

end

board1 = ToDoBoard.new('New Board')
board1.run