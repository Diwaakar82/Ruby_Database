require "mysql2"
require 'dotenv/load'

username = ENV['DB_USER']
password = ENV['PASSWORD']
database = ENV['DATABASE']

client = Mysql2::Client.new(host: "localhost", username: username, password: password, database: database)

def createTable (client,table_name, *args)
    request = "CREATE TABLE #{table_name} ("

    args.each do |value|
        request += value
        request += ','
    end
    request [request.length - 1] = ')'
    client.query (request)
end

def insert (client, table_name, *args)
    request = "INSERT INTO #{table_name} VALUES ("
    args.each do |value|
        formatted_value = value.is_a?(String) ? "'#{value}'" : value.to_s
        request += formatted_value
        request += ','
    end

    request [request.length - 1] = ')'
    client.query (request)
end


def update (client, table_name, condition)
    request = "UPDATE #{table_name} #{condition}"
    client.query (request)
end

def delete (client, table_name, condition)
    request = "DELETE FROM #{table_name} #{condition}"
    client.query (request)
end

def getDetails (client, table_name,condition,*columns)
    request = "SELECT "
    
    columns.each do |value|
        request += value
        request += ','
    end

    request [request.length - 1] = ""
    request += "FROM #{table_name} #{condition}"

    client.query (request)
end

def displayResults(rows)
    puts "rows in the query :"
    rows.each do |row|
        puts row
    end
end

table = "info3"


createTable(client,table,"USERID INTEGER","NAME VARCHAR (20)","AGE INTEGER","NATIVE VARCHAR (20)")
insert(client,table,1,"GOWTHAM",21,"INDIA")
insert(client,table,2,"DARRSHAN",20,"INDIA")
insert(client,table,3,"VENKAT",21,"INDIA")

displayResults(getDetails(client, table,"","*"))

update(client, table, "SET USERID = 4 WHERE NAME = \"VENKAT\"")

displayResults(getDetails(client, table,"","*"))

delete(client, table, "WHERE USERID = 4")

displayResults(getDetails(client, table,"","*"))

# Close the connection when done
client.close



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


