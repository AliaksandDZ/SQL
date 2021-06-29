 cls



write-host "before script" -ForegroundColor Green
 Invoke-Command -Credential administrator -ComputerName 192.168.1.1 -ScriptBlock{ Get-ChildItem E:\test\2.2}

 
  #созда бд PCDRIVE
 
sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "create database PCDRIVE

on
PRIMARY
(
Name=PCDRIVEdev,
FileName='E:\test\2.2\PCDRIVEmdf',
size=50mb,
Filegrowth=5mb,
MaxSize=Unlimited
)

log on
(
Name=PCDRIVElog,
size=5mb,
FileName='E:\test\2.2\PCDRIVElog',
Filegrowth=5mb,
MaxSize=Unlimited
)
"    


 #созд таблицу
 sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "
create table PCDRIVE.dbo.PhysicalDisk
(
FriendlyName varchar(50)  null,
BusType varchar(10) NUlL,
HealthStatus varchar(10) Null,
Size varchar(50)  null,
MediaType binary(10) null
);


"



#вывести парам жд вм ,просто посмотреть что есть

 Invoke-Command -Credential administrator -ComputerName 192.168.1.1 -ScriptBlock{ Get-PhysicalDisk |
 select -Property FriendlyName,BusType,HealthStatus,Size,MediaType}

 



 #создать переменную $friendlyname, которая массивом раскидается по таблице dbo.PhysicalDisk в столбике friendlyname
 $friendlyname = Invoke-Command -Credential administrator -ComputerName 192.168.1.1 -ScriptBlock{ Get-PhysicalDisk |
 select -Property FriendlyName}

         #разбить переменную $friendlyname на несколько переменных , каждая со своих ssd/hdd
         $friendlyname0=$friendlyname[0].FriendlyName
         $friendlyname1=$friendlyname[1].FriendlyName

                 #один ссд - в 1ый кортеж в 1 атрибут, если бд была пустая
                 sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "
                 insert into PCDRIVE.dbo.PhysicalDisk([friendlyname]) values ('$friendlyname0')"
                  #второй hdd - в 2ый кортеж в 1 атрибут, если бд была пустая
                  sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "
                 insert into PCDRIVE.dbo.PhysicalDisk([friendlyname]) values ('$friendlyname1')"





#создать переменную $Butstype, которая массивом раскидается по таблице dbo.PhysicalDisk в столбике Butstype
 $BusType = Invoke-Command -Credential administrator -ComputerName 192.168.1.1 -ScriptBlock{ Get-PhysicalDisk |
 select -Property BusType}

         #разбить переменную $Butstype на несколько переменных , каждая для своей шины для каждого диска
         $Bustype0=$BusType[0].Bustype
         $Bustype1=$BusType[1].Bustype

                 #первая шина в 1 кортеж 2 атрибут, если бд была пустая
                 sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "
                 insert into PCDRIVE.dbo.PhysicalDisk([Bustype]) values ('$Bustype0')"
                  #вторая шина в 2 кортеж 2 атрибут, если бд была пустая
                  sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "
                 insert into PCDRIVE.dbo.PhysicalDisk([Bustype]) values ('$Bustype1')"



 




 
#создать переменную $HealthStatus, которая массивом раскидается по таблице dbo.PhysicalDisk в столбике HealthStatus
 $HealthStatus = Invoke-Command -Credential administrator -ComputerName 192.168.1.1 -ScriptBlock{ Get-PhysicalDisk |
 select -Property HealthStatus}

         #разбить переменную $Butstype на несколько переменных , каждая для своей шины для каждого диска
        $HealthStatus0=$HealthStatus[0].HealthStatus
         $HealthStatus1=$HealthStatus[1].HealthStatus

                 #1ый хелсчек в 1 кортеж 3 атрибут, если бд была пустая
                 sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "
                 insert into PCDRIVE.dbo.PhysicalDisk([HealthStatus]) values ('$HealthStatus0')"
                 #2ый хелсчек в 2 кортеж 3 атрибут, если бд была пустая
                  sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "
                 insert into PCDRIVE.dbo.PhysicalDisk([HealthStatus]) values ('$HealthStatus1')"



 







 #создать переменную $size, которая массивом раскидается по таблице dbo.PhysicalDisk в столбике Size
 $Size = Invoke-Command  -Credential administrator 192.168.1.1 -ScriptBlock{ Get-PhysicalDisk |
 select -Property Size}

         #разбить переменную $Size на несколько переменных 
        $Size0= $Size[0].Size
         $Size1= $Size[1].size

                 #1ый Size в 1 кортеж 4 атрибут, если бд была пустая
                 sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "
                 insert into PCDRIVE.dbo.PhysicalDisk([Size]) values ('$Size0')"
                 #2ый Size в 2 кортеж 4 атрибут, если бд была пустая
                  sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "
                 insert into PCDRIVE.dbo.PhysicalDisk([Size]) values ('$Size1')"










 #создать переменную $MediaType, которая массивом раскидается по таблице dbo.PhysicalDisk в столбике MediaType
 $MediaType = Invoke-Command  -Credential administrator 192.168.1.1 -ScriptBlock{ Get-PhysicalDisk |
 select -Property MediaType}

         #разбить переменную $MediaType на несколько переменных 
        $MediaType0= $MediaType[0].PSComputerName
         $MediaType1= $MediaType[1].PSComputerName

                 #1ый MediaType в 1 кортеж 5 атрибут, если бд была пустая
                 sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "
                 insert into PCDRIVE.dbo.PhysicalDisk([MediaType]) values ('$MediaType0')"
                 #2ый MediaType в 2 кортеж 5 атрибут, если бд была пустая
                  sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "
                 insert into PCDRIVE.dbo.PhysicalDisk([MediaType]) values ('$MediaType1')"




                 






write-host "after script" -ForegroundColor Green
 Invoke-Command -Credential administrator -ComputerName 192.168.1.1 -ScriptBlock{ Get-ChildItem E:\test\2.2}
