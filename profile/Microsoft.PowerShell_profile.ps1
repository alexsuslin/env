#Aliases                                                                                                                        
Set-Alias vim 'C:\Program Files (x86)\vim\vim80\vim.exe'                                                                        
Set-Alias subl 'C:\Program Files\Sublime Text 3\sublime_text.exe'                                                               
Set-Alias rstudio 'C:\Program Files\RStudio\bin\rstudio.exe'                                                                    
Set-Alias far 'C:\Program Files\Far Manager\Far.exe'                                                                            
Set-Alias ts treesizefree                                                                                                       
Set-Alias treesize treesizefree                                                                                                 
Set-Alias tree-size treesizefree                                                                                                
Set-Alias cua ChocoUpgradeAll                                                                                                   
Set-Alias restart Restart-Computer                                                                                              
Set-Alias reboot Restart-Computer                                                                                               
Set-Alias rdp mstsc                                                                                                             
Set-Alias rdc mstsc                                                                                                             
                                                                                                                                
# Chocolatey profile                                                                                                            
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"                                                    
if (Test-Path($ChocolateyProfile)) {                                                                                            
  Import-Module "$ChocolateyProfile"                                                                                            
}                                                                                                                               
                                                                                                                                
Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-a4faccd\src\posh-git.psd1'
                                                                                                                                
#User Functions                                                                                                                 
function touch {set-content -Path ($args[0]) -Value ($null)}                                                                    
                                                                                                                                
### Usage from comments - Add to the system environment variable ###                                                            
function Append-ToPath ($path){                                                                                                 
        if(Test-Path $path){                                                                                                    
                [Environment]::SetEnvironmentVariable("PATH", $env:Path + ';' + $path, [EnvironmentVariableTarget]::Machine)    
                Write-Information "'$p' was succesfully added to system path"                                                   
                refreshenv                                                                                                      
        } else {                                                                                                                
                Write-Error "'$p' is not a path"                                                                                
        }                                                                                                                       
}                                                                                                                               
                                                                                                                                
### Upgrade all software                                                                                                        
function ChocoUpgradeAll { choco upgrade all -y }                                                                               
                                                                                                                                
## HOME VPN                                                                                                                     
function vpn([string]$connection="home", [switch]$d) { if($d){rasdial /disconnect} else {rasphone -d $connection} }         

## Create bat file to allow quick apps aliases instead of adding lots of path variables
function Add-AppAlias($alias, $path, [switch]$nw){

    $batlocation = "$HOME\myapps"
    if($alias -eq $null -or $path -eq $null){
        Write-Error "Please specify both alias and path to the program"
        return
    }

    if(!(Test-Path -Path $path)){
        Write-Error "Cannot find the path '$path'"
        return
    } 


    if(!(Test-Path -Path $batlocation)){
        New-Item -ItemType directory -Path $batlocation
        Append-ToPath $batlocation 
    }

    $aliaspath = "$batlocation\$alias.bat"

    if(Test-Path -Path $aliaspath){
        Write-Error "Sorry, the alias already exists: $aliaspath"
        return
    }

    $newWindowContent = ""
    if($nw) { $newWindowContent = 'start "" ' }

    $content = @"
@echo off
$newWindowContent"$path" %*
"@

    $content | Out-File -encoding ASCII -append -FilePath $aliaspath
    Write-Host "$alias was added successfully"
}
    
