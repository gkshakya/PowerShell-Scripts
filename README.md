# PowerShell-Scripts
Collection of all PowerShell scripts I created for solving various problems

1. Duo_admin_lifecycle_script
Description: script to automatically notify a particular AD group upon departure/deactivation of a Duo admin account. 
Prerequisites: to run this script, these modules must be present in your Powershell environment.
  i. Activedirectory
  ii. Duo-PSModule @https://github.com/mbegan/Duo-PSModule
Recommendation: To enable automatic run of this script at a regular predefined interval, use Windows task-scheduler
