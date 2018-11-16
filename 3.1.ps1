#sozd full backup i pologitb v papky


 Invoke-Sqlcmd -Query "select @@servername" -ServerInstance 192.168.1.2 |Tee-Object -filepath "C:\Users\Administrator\Desktop\ExtTask1.txt" -Append

 Invoke-Sqlcmd -Query "backup database AdventureWorks2012  TO DISK='C:\Test\Adventure database for extra task1\backup\AdventureWorks2012 .BAK' with INIT" -ServerInstance 192.168.1.2 | Get-ChildItem "C:\Test\Adventure database for extra task1\backup\"|Tee-Object -filepath "C:\Users\Administrator\Desktop\ExtTask1.txt" -Append


#dostyp k faily
 $acl = New-Object System.Security.AccessControl.DirectorySecurity
 $acl.SetAccessRuleProtection($true,$true)
 $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("NT authority\everyone", "fullcontrol","allow")
 $acl.AddAccessRule($rule)
 $acl | set-acl -Path "C:\Test\Adventure database for extra task1\backup\AdventureWorks2012 .BAK" 
 Get-Acl "C:\Test\new-database\new_database.ldf" | format-list|Tee-Object -filepath "C:\Users\Administrator\Desktop\ExtTask1.txt" -Append



#zabrat backup i vstavit v instance3 i sozd papky pod novuu bd v etom instance
 Invoke-Sqlcmd -Query "select @@servername" -ServerInstance WIN-R2KSK2387B5\INSTANCE3 | Tee-Object -filepath "C:\Users\Administrator\Desktop\ExtTask1.txt" -Append

 Invoke-Sqlcmd -Query "USE [master]
RESTORE DATABASE [AdventureWorks2012] FROM  DISK = N'C:\Test\Adventure database for extra task1\backup\AdventureWorks2012 .BAK' WITH  FILE = 1,  MOVE N'AdventureWorks2012_Data' TO N'C:\Test\Adventure database for extra task1\place for db for INCTANCE3\AdventrueWorks_Instance3.mdf',  MOVE N'AdventureWorks2012_Log' TO N'C:\Test\Adventure database for extra task1\place for db for INCTANCE3\AdventrueWorks_Instance3.ldf',  NOUNLOAD,  STATS = 5

GO" -ServerInstance WIN-R2KSK2387B5\INSTANCE3 | Tee-Object -filepath "C:\Users\Administrator\Desktop\ExtTask1.txt" -Append


#---
#delet izmeneni9 v baze i pokaz eto
 Invoke-Sqlcmd -Query "select city from AdventureWorks2012.Person.Address
where AddressID = 1;

update AdventureWorks2012.Person.Address
set city = 'minsk'
where AddressID = 1;

select city from AdventureWorks2012.Person.Address
where AddressID = 1;
" -ServerInstance  WIN-R2KSK2387B5\INSTANCE3 | Tee-Object -filepath "C:\Users\Administrator\Desktop\ExtTask1.txt" -Append



#----
#comprassed backup

 Invoke-Sqlcmd -Query "BACKUP DATABASE [AdventureWorks2012] TO  DISK = N'C:\Test\Adventure database for extra task1\backup\AdventureWorks2012_full_compressed.bak' WITH NOFORMAT, NOINIT,  NAME = N'AdventureWorks2012-Full Database Backup_compressed', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
GO" -ServerInstance WIN-R2KSK2387B5\INSTANCE3 |Get-ChildItem "C:\Test\Adventure database for extra task1\backup\"|Tee-Object -filepath "C:\Users\Administrator\Desktop\ExtTask1.txt" -Append




$acl = New-Object System.Security.AccessControl.DirectorySecurity
 $acl.SetAccessRuleProtection($true,$true)
 $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("NT authority\everyone", "fullcontrol","allow")
 $acl.AddAccessRule($rule)
 $acl | set-acl -Path "C:\Test\Adventure database for extra task1\backup\AdventureWorks2012_full_compressed.bak" 
  Get-Acl "C:\Test\Adventure database for extra task1\backup\AdventureWorks2012_full_compressed.bak" | format-list| Tee-Object -filepath "C:\Users\Administrator\Desktop\ExtTask1.txt" -Append




#-----
#vosst etot comprased backup na instance

 Invoke-Sqlcmd -Query "USE [master]
RESTORE DATABASE [AdventureWorks2012_compressed_restored] FROM  DISK = N'C:\Test\Adventure database for extra task1\backup\AdventureWorks2012_full_compressed.bak' WITH  FILE = 1,  MOVE N'AdventureWorks2012_Data' TO N'C:\Test\Adventure database for extra task1\backup\compressed and after restored database\AdventureWorks_compressed_restored.mdf',  MOVE N'AdventureWorks2012_Log' TO N'C:\Test\Adventure database for extra task1\backup\compressed and after restored database\AdventureWorks_compressed_restored.ldf',  NOUNLOAD,  STATS = 5

GO" -ServerInstance WIN-R2KSK2387B5\INSTANCE2 
write-host "#vosst etot comprased backup na instance" | Tee-Object -filepath "C:\Users\Administrator\Desktop\ExtTask1.txt" -Append

