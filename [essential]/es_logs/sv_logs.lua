-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"

-- MySQL:open("IP", "databasname", "user", "password")
MySQL:open("127.0.0.1", "gta5_script_logs", "root", "1202")

AddEventHandler('es:chatMessage', function(source, msg, user)
	local tstamp2 = os.date("*t", os.time())

	MySQL:executeQuery("INSERT INTO chat (`sender`, `timestamp`, `message`) VALUES ('@username', '@now', '@message')",
		{['@username'] = user.identifier, ['@message'] = msg, ['@now'] = os.date(tstamp2.year .. "-" .. tstamp2.month .. "-" .. tstamp2.day .. " " .. tstamp2.hour .. ":" .. tstamp2.min .. ":" .. tstamp2.sec)})
end)

AddEventHandler('es:adminCommandRan', function(source, msg, user)
	local tstamp2 = os.date("*t", os.time())

	msg = table.concat(msg, " ")

	MySQL:executeQuery("INSERT INTO admin (`sender`, `timestamp`, `command`) VALUES ('@username', '@now', '@message')",
		{['@username'] = user.identifier, ['@message'] = msg, ['@now'] = os.date(tstamp2.year .. "-" .. tstamp2.month .. "-" .. tstamp2.day .. " " .. tstamp2.hour .. ":" .. tstamp2.min .. ":" .. tstamp2.sec)})
end)

AddEventHandler('es:userCommandRan', function(source, msg, user)
	local tstamp2 = os.date("*t", os.time())

	msg = table.concat(msg, " ")

	MySQL:executeQuery("INSERT INTO commands (`sender`, `timestamp`, `command`) VALUES ('@username', '@now', '@message')",
		{['@username'] = user.identifier, ['@message'] = msg, ['@now'] = os.date(tstamp2.year .. "-" .. tstamp2.month .. "-" .. tstamp2.day .. " " .. tstamp2.hour .. ":" .. tstamp2.min .. ":" .. tstamp2.sec)})
end)