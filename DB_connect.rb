# Make sure to require the mysql2 gem at the beginning of your Ruby script or file
require "mysql2"

# Replace the placeholders with your actual MySQL server details
client = Mysql2::Client.new(host: "localhost", username: "root", password: "1234", database: "TESTDB")

results = client.query ("CREATE TABLE USER (USERID INTEGER, NAME VARCHAR (20), AGE INTEGER, NATIVE VARCHAR (20))")

# Insert values into table
client.query ("INSERT INTO USER VALUES (1, \"GOWTHAM\", 21, \"INDIA\")")
client.query ("INSERT INTO USER VALUES (2, \"DARRSHAN\", 20, \"INDIA\")")
client.query ("INSERT INTO USER VALUES (1, \"VENKAT\", 21, \"INDIA\")")

# # Update existing records
puts client.query ("UPDATE USER SET USERID = 3 WHERE NAME = \"VENKAT\"")

# #Delete record
puts client.query ("DELETE FROM USER WHERE USERID = 3")

result = client.query ("SELECT * FROM USER;")

result.each do |row|
    puts row
end

# Close the connection when done
client.close
