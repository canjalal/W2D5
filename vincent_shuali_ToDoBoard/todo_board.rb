require_relative "list"

class ToDoBoard
    def initialize(label)
        @lista = List.new(label)
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

Welcome to the ToDoBoard! Enter a command.
------------------------------------------

mktodo <title> <deadline> <optional description>
- makes a todo with the given information

up <index> <optional amount>
- raises the todo up the list

down <index> <optional amount>
- lowers the todo down the list

swap <index_1> <index_2>
- swaps the position of todos

sort
- sorts the todos by date

priority
- prints the todo at the top of the list

print <optional index>
- prints all todos if no index is provided
- prints full information of the specified todo if an index is provided

quit
- returns false
        """

# userinput.match(/^([a-z]+)(?:\s(\S+))?(?:\s(\S+))?(?:\s(.*+))?$/)


        userinput = gets.chomp

        usermatch = userinput.match(/^([a-z]+)(?:\s(\S+))?(?:\s(\S+))?(?:\s(.*+))?$/)

        raise RuntimeError.new("Invalid command!") if(!usermatch)

        cmd = usermatch[1]

        case cmd

        when 'mktodo'
            title = usermatch[2]
            deadline = usermatch[3]
            description = usermatch[4]

            @lista.add_item(title, deadline, description)
            puts "Added item #{title} with deadline #{deadline}: #{description}"

        when 'up'
            begin
                index = usermatch[2].to_i
                amount = [usermatch[3].to_i, 1].max # if nil, turns to 0
            rescue
                "Oops invalid arguments for up"
            else
                @lista.up(index, amount)
            end

        when 'down'
            begin
                index = usermatch[2].to_i
                amount = [usermatch[3].to_i, 1].max # if nil, turns to 0
            rescue
                "Oops invalid arguments for down"
            else
                @lista.down(index, amount)
            end

        when 'swap'
            begin
                index1 = usermatch[2].to_i
                index2 = usermatch[3].to_i
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
            if (usermatch[2])
                @lista.print_full_item(usermatch[2].to_i)
            else
                @lista.print
            end

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

end