class Item
    attr_accessor :title, :description
    attr_reader :deadline
    def self.valid_date?(date_string)
        return date_string.match?(/^((?:1|2)\d{3})-(0[1-9]|1[0-2])-(0[1-9]|(?:1|2)[0-9]|3[0-1])/)

    end

    def initialize(title, deadline, description)
        @title = title
        self.deadline = deadline  # the self is needed here to make it clear that
                                    # this is the method and not the local variable
        @description = description

    end

    def deadline=(new_deadline)
        unless Item.valid_date?(new_deadline)
            raise RuntimeError.new("Date must be in the format of YYYY-MM-DD")
        end
        @deadline = new_deadline
    end



end

# p Item.valid_date?('2019-10-25') # true
# p Item.valid_date?('1912-06-23') # true
# p Item.valid_date?('2018-13-20') # false
# p Item.valid_date?('2018-12-32') # false
# p Item.valid_date?('10-25-2019') # false

# Item.new('Fix login page', '2019-10-25', 'The page loads too slow.')

# Item.new(
#     'Buy Cheese',
#     '2019-10-21',
#     'We require American, Swiss, Feta, and Mozzarella cheese for the Happy hour!'
# )

# Item.new(
#     'Fix checkout page',
#     '10-25-2019',
#     'The font is too small.'
# ) # raises error due to invalid date