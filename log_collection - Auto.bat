@echo off
pushd "%~dp0"
if not exist "log" mkdir log

color 02
echo "Get system infomation..."

color 07
Systeminfo > %cd%\log\log_systeminfo.txt
echo Done
echo ********************************************************

color 02
echo "Get share folder infomation..."

color 07
net share
net share > %cd%\log\log_netshare.txt
%cd%\tool\accesschk.exe -h * >> %cd%\log\log_netshare.txt
echo Done
echo ********************************************************

color 02
echo "Get remotely file open..."

color 07
net file
net file > %cd%\log\log_remotely_file_open.txt
%cd%\tool\psfile.exe
%cd%\tool\psfile.exe >> %cd%\log\log_remotely_file_open.txt
echo Done
echo ********************************************************

color 02
echo "Get account infomation...."

color 07
net user
net user > %cd%\log\log_netuser.txt
echo Done
echo ********************************************************

color 02
echo "Copy Windows Event...."

color 07
ROBOCOPY C:\Windows\System32\winevt\Logs %cd%\log\windows_event
echo Done
echo ********************************************************

color 02
echo "Get logon session..."

color 07
%cd%\tool\logonsessions.exe > %cd%\log\log_logonsession.txt
echo ************
echo "List user logged on via resource shares"

%cd%\tool\PsLoggedon.exe
%cd%\tool\PsLoggedon.exe >> %cd%\log\log_logonsession.txt
echo Done
echo ********************************************************

color 02
echo "Get networking infomation..."

color 07
ipconfig -all > %cd%\log\log_network_information.txt
%cd%\tool\tcpvcon.exe > %cd%\log\log_network_endpoint.txt
%cd%\tool\promqry.exe > %cd%\log\log_network_promiscuous_mode.txt
netstat -r > %cd%\log\log_network_routing.txt
echo Done
echo ********************************************************

color 02
echo "Get Service Information..."

color 07
%cd%\tool\PsService.exe > %cd%\log\log_service_information.txt
schtasks
schtasks > %cd%\log\log_service_schedule.txt
echo Done
echo ********************************************************

color 02
echo "Shows processes configured to autostart during boot...."

color 07
%cd%\tool\autorunsc.exe > %cd%\log\log_startup_process.txt
echo Done
echo ********************************************************

color 02
echo "Shows system log and delete after show...."

color 07
%cd%\tool\psloglist.exe -c > %cd%\log\log_system_log.txt
echo Done
echo ********************************************************

color 02
echo "Show user permission..."

color 07
%cd%\tool\accesschk.exe -a * > %cd%\log\log_securable_permission.txt
%cd%\tool\accesschk.exe -c * > %cd%\log\log_user_permission_service.txt
echo Done
echo ********************************************************

color 02
echo "Get DLL file is using..."

color 07
%cd%\tool\Listdlls64.exe > %cd%\log\log_DLL.txt
echo Done
echo ********************************************************

color 02
echo "Danh sach file trong Windows"
pause
color 07
dir -h /od C:\Windows
echo ***************************************

echo "Danh sach file trong System32"
pause
dir -h /od C:\Windows\System32
echo ***************************************


echo "Danh sach file trong Syswow64"
pause
dir -h /od C:\Windows\SysWOW64
echo ***************************************


echo "Danh sach file trong Temp"
pause
dir -h /od C:\Windows\Temp
echo ***************************************


echo "Danh sach file trong Prefetch"
pause
dir -h /od C:\Windows\Prefetch
echo ***************************************


echo "Danh sach file trong AppData"
pause
dir -h /od %Appdata%
echo ***************************************

echo "Danh sach file Startup"
pause
dir -h /od %Appdata%\Microsoft\Windows\Start Menu\Programs\Startup
echo Finished
popd
