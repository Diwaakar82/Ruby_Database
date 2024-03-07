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
    puts request
    client.query (request)
end

def insert (client, table_name, *args)
    request = "INSERT INTO #{table_name} VALUES ("
    puts request
    args.each do |value|
        formatted_value = value.is_a?(String) ? "'#{value}'" : value.to_s
        request += formatted_value
        request += ','
    end

    request [request.length - 1] = ')'
    puts request
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
    rows.each do |row|
        puts row
    end
end

# createTable (client,"info","USERID INTEGER","NAME VARCHAR (20)","AGE INTEGER","NATIVE VARCHAR (20)")
# insert(client,"info",1,"GOWTHAM",21,"INDIA")
# insert(client,"info",2,"DARRSHAN",20,"INDIA")
# insert(client,"info",3,"VENKAT",21,"INDIA")

displayResults(getDetails(client, "info","","*"))

update(client, "info", "SET USERID = 4 WHERE NAME = \"VENKAT\"")

displayResults(getDetails(client, "info","","*"))

delete(client, "info", "WHERE USERID = 4")

# Close the connection when done
client.close


# Modify into functions
# Add credentials into a file and not directly in the code
