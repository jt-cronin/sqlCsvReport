require "pry"
require "CSV"
require "pg"

def categoryTotal(people, account, category, total = 0)
	people[account][category].each {|amount| total += amount}
	total.round(2)
end


def categoryAverage(people, account, category)
	(categoryTotal(people, account, category) /people[account][category].length).round(2)
end


def calcBalance(people, account, balance = 0)
	people[account].each {|category, transaction| transaction.each {|amount| balance += amount} }
	balance.round(2)
end


def displayReg people, account
	puts "Account: #{account}.. Balance: $#{calcBalance(people, account)}"
	puts "Category".ljust(20) + "Total Spent".ljust(20) + "Average Transaction"
	people[account].each do |category, transaction|
		puts category.to_s.ljust(20) + "$" +categoryTotal(people,account, category).to_s.ljust(20) + "$" + categoryAverage(people, account, category).to_s.ljust(20)
	end
end


def displayHTML people, account
	puts "Here is the display for HTML"
	puts
	puts "<h1>#{account}</h1>\n<p>$#{calcBalance(people, account)}</p>\n<hr>\n<table>"
	puts "\t<tr>\n\t\t<th>Category</th>\n\t\t<th>Total Spent</th>\n\t\t<th>Avg Transaction</th>\n\t</tr>"
	puts
	people[account].each do |category, transaction|
		puts "\t<tr>\n\t\t<td>#{category.to_s}</td>\n\t\t<td>$#{categoryTotal(people, account, category).to_s}</td>\n\t\t<td>$#{categoryAverage(people, account, category).to_s}</td\n\t</tr>"
	end
	puts "</table>"
end



def displayCSV people, account
	puts "Here is the display for CSV"
	puts
	puts "#{account},#{calcBalance(people, account)}"
	puts "Category,Total Spent,Avg Transaction"
	people[account].each do |category, transaction|
		puts "#{category},#{categoryTotal(people, account, category)},#{categoryAverage(people, account, category)}"
	end
	nil
end



def validName (people, name)
	hasKey = false
	if people.has_key?(name)
		puts "Welcome, let me pull up your account"
		hasKey = true
	else
		abort "Sorry, we do not recognize #{@name} as an account" 
	end
	return hasKey
end

	