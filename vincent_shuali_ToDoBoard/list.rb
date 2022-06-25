require_relative "./item.rb"
class List

    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description = "")
        begin
            @items << Item.new(title, deadline, description)
        rescue RuntimeError => exception
            puts exception.message
            return false
        else
            return true
        end
    end

    def size
        @items.length
    end

    def valid_index?(index)
        index >= 0 && index < self.size
    end

    def swap(index_1, index_2)
        if(self.valid_index?(index_1) && self.valid_index?(index_2))
            @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
            return true
        else
            return false
        end
    end

    def [](index)
        if(self.valid_index?(index))
            @items[index]
        else
            nil
        end
    end

    def priority
        return self[0]
    end

    def print
        puts "--------------------------------------------------------------------------------"
        puts @label
        puts "--------------------------------------------------------------------------------"
        puts "Index | Item                                                       |  Deadline  "
        puts "--------------------------------------------------------------------------------"
        @items.each.with_index do |item, idx|
            puts "#{idx.to_s.rjust(5)} | #{item.title.ljust(58)} | #{item.deadline.rjust(10)}"
            puts "--------------------------------------------------------------------------------"
        end
        return "\n"
    end

    def print_full_item(index)
        if self.valid_index?(index)
            puts "--------------------------------------------------------------------------------"
            puts "#{(self[index].title + " : ").ljust(40)} #{self[index].deadline.rjust(38)}"
            puts self[index].description
            puts "--------------------------------------------------------------------------------" 
        end

        return "\n"

    end

    def print_priority
        self.print_full_item(0)
    end

    def up(index, amount = 1)
        if(self.valid_index?(index) && index > amount)
            currindex = index

            until(currindex == index - amount)
                self.swap(currindex, currindex - 1)
                currindex -= 1
            end
            true
        else
            false
        end
    end

    def down(index, amount = 1)

        if(self.valid_index?(index))
            amount = [amount, self.size - index - 1].min
            currindex = index

            until(currindex == index + amount)
                self.swap(currindex, currindex + 1)
                currindex += 1
            end
            return true
        else
            return false
        end
    end

    def sort_by_date!
        @items.sort_by! {|item| item.deadline}
        true
    end

    
end