require "mysql2"
require 'dotenv/load'

class DB 
    @@username = ENV['DB_USER']
    @@password = ENV['PASSWORD']
    @@tables = []

    def initialize(database)
        @database = database
        @table_name = 'A'
        @client = Mysql2::Client.new(host: "localhost", username: @@username, password: @@password, database: @database)
    end

    def createTable ()
        puts "Enter table name: "
        @table_name = gets
        
        @@tables << @table_name
        request = "CREATE TABLE #{@table_name} ("
        
        ch = 'y'
        loop do
            puts "Enter column name: "
            request += gets
            request += " "
            puts "Enter type: "
            request += gets
            request += ","

            puts "Are there more columns: ('y' or 'n')"
            ch = gets

            # puts "Input: #{ch}"
            break if ch[0] != 'y' || ch[0] != "y"
        end

        request [-1] = ')'
        request += ';'
        @client.query (request)
    end

    def getDetails ()
        request = "SELECT "
        
        puts "1. Display all rows\n2. Show certain columns\n"
        choice = gets

        case choice
            when 1
                request += "* FROM #{@table_name};"
            when 2
                ch = 'y'
                loop do
                    puts "Enter column name: "
                    request += gets
                    request += ','

                    puts "Are there more columns: ('y' or 'n')"
                    ch = gets

                    break if ch[0] != 'y'
                end
            else
                puts "Invalid choice"
                return
        end
    
        request [-1] = ""
        request += "FROM #{@table_name}"
        request += ';'
    
        @client.query (request)
    end

    def insert ()
        request = "INSERT INTO #{@table_name} VALUES ("

        ch = 'y'
        loop do
            puts "Enter value: "
            value = gets
            value = value.is_a?(String) ? "'#{value}'" : value.to_s
            request += value
            request += ',' 

            puts "Are there more columns: ('y' or 'n')"
            ch = gets

            break if ch[0] != 'y'
        end
    
        request [-1] = ')'
        @client.query (request)
    end

    def update ()
        puts "Enter column to change: "
        column = gets
        puts "Value to update: "
        value = gets
        value = value.is_a?(String) ? "'#{value}'" : value.to_s

        request = "UPDATE #{@table_name} SET #{column} = #{value}"
        @client.query (request)
    end

    def delete ()
        puts "Enter column to check: "
        column = gets
        puts "Delete if value is: "
        value = gets
        value = value.is_a?(String) ? "'#{value}'" : value.to_s

        request = "DELETE FROM #{@table_name} WHERE #{column} = #{value}"
        @client.query (request)
    end

    def close ()
        @client.close
    end

end

db1 = DB.new(ENV['DATABASE'])
# db1.createTable
db1.insert
db1.insert
db1.close()


# changes 

# Modify into functions
# Add credentials into a file and not directly in the code

# test cases - 1
# tested created new table with info1 as table name - worked correctly

# test cases -2 
# tested insert new value into the function with given table structure - worked correctly

# test cases - 3
# tested update table - worked correctly

# test cases - 4
# test delete table with condition - worked correctly