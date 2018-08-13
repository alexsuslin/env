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
            
$PoshGitModule = "C:\tools\poshgit\dahlbyk-posh-git-4184928\src\posh-git.psd1"                                                                                                                    
if(Test-Path($PoshGitModule)) {
  Import-Module $PoshGitModule 
}

# Load Choco Helper Functions
$helpersPath = "$env:ChocolateyInstall\helpers";
if(Test-Path($helpersPath)){
  Get-Item $helpersPath\functions\*.ps1 |? { -not ($_.Name.Contains(".Tests.")) } |% { . $_.FullName;  }          
}
                                                                                                                                
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

    
