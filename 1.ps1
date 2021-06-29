cls
    
 Enter-PSSession -ComputerName SQL1 -Credential administrator 



#try – как попытка проверки на ошибки
try{


write-host "before installation"
Get-ChildItem E:\test

#залазим в SQL и меняем по заданию файлы
Invoke-Sqlcmd -Query "

alter database tempdb
modify file 
(name = tempdev,
 size = 10MB, maxsize= Unlimited, FILEGROWTH = 5MB
);
alter database tempdb
modify file 
(name = templog,
 size = 10MB, maxsize= Unlimited, FILEGROWTH = 1MB
);

alter database tempdb 
modify file         
(name = tempdev,   
filename = 'E:\test\extraoption\tempdb.mdf'); 
alter database tempdb
modify file 
(name = templog,   
filename = 'E:\test\extraoption\tempdb.ldf');


"






#-credential (get-credential) - togda ne pobit, skoree vsego izza try i catch
#-serverinstance 192.168.1.1 - togda ne pobit, skoree vsego izza try i catch

write-host "after installation"
Get-ChildItem E:\test\extraoption


#лезем в SQL 2 раз и вытягиваем параметры, которые написаны в селекте
$needsize = Invoke-Sqlcmd -Query "SELECT name, physical_name,size,max_size,growth  
FROM sys.master_files  
WHERE database_id = DB_ID(N'tempdb');"


#переменная size – будет считать ток сумму того, скок занимают файлыбазы SQL и сравнинвают с физическим место
$size = $needsize | Measure-Object -Property size -Sum
if ($size.sum -ge $disk.FreeSpace ){write-host "da, mesta hvataet" -foregroundcolor green} else {write-host "net, mesta ne hvataet" -foregroundcolor red}

#переменная диск- скок физически свободного мета

#переменная диск- скок физически свободного мета
$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='E:'" |
Select-Object Size,FreeSpace 





}

#первая попытка отладчика, без фактической отладки. 
catch {
write-host "The error:"
write-host $_ -ForegroundColor Yellow
write-host "Call Admin! "}


#проверка на совпадания имени
$location="E:\test\extraoption"
Set-Location $location
Get-ChildItem | foreach {if ($_.name -eq "1.txt") {Write-Host  "file s takim imenem prisytsvuet v  $location" -foregroundcolor green}  }



exit

