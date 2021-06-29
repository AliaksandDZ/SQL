cls
 #провека бд Human...  
  $perem = (sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "SELECT name FROM master.dbo.sysdatabases" | Out-String -Stream | Select-String "HumanResources"  )
 $rez= $perem -match "HumanResources"     
  if ($rez -eq "True") {(sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "drop database HumanResources") ;write-host "такая бд уже существует и мы ее сейчас удалим" -ForegroundColor red} else{Write-Host 'такая бд не существует' -ForegroundColor Green}  
  $perem = 0  
  #проверка бд Inter..
   $perem = (sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "SELECT name FROM master.dbo.sysdatabases" | Out-String -Stream | Select-String "InternetSales"  )
 $rez= $perem -match "InternetSales"     
  if ($rez -eq "True") {(sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "drop database InternetSales") ;write-host "такая бд уже существует и мы ее сейчас удалим" -ForegroundColor red} else{Write-Host 'такая бд не существует' -ForegroundColor green}
  $perem = 0                      
  
  
  
  
  
 #созда бд Human
 
sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "create database HumanResources 

on
PRIMARY
(
Name=HumanResourcesdev,
FileName='E:\test\extraoption\Humanresources.mdf',
size=50mb,
Filegrowth=5mb,
MaxSize=Unlimited
)

log on
(
Name=Humanresourceslog,
size=5mb,
FileName='E:\test\extraoption\Humanresources.log',
Filegrowth=5mb,
MaxSize=Unlimited
)
"    
          
 #созда бд Internetsales

sqlcmd -S 192.168.1.1 -U sa -PPa$$w0rd -Q "create database InternetSales

on
PRIMARY
(
Name=HumanResourcesdev,
FileName='E:\test\extraoption\InternetSales.mdf',
size=50mb,
Filegrowth=5mb,
MaxSize=Unlimited
)

log on
(
Name=Humanresourceslog,
size=5mb,
FileName='E:\test\extraoption\InternetSales.log',
Filegrowth=5mb,
MaxSize=Unlimited
)
"    
        

     
 
