Import-Module Duo 
Import-Module ActiveDirectory

# Function for checking the status of the user in AD
function check-status ($ldap)
    {
    try
        {
        $var = Get-ADUser $ldap -Properties Enabled
        Write-Host $var.Enabled
        if ($var.Enabled = True)
            {pass
            }
        else
            {
            send-msg $ldap
            }
        }

    catch
        {
        $errormsg = $_.Exception.Message
        Write-Host "there was an error while fetching the details of this account. Please check the error."
        }
    }
# function for sending the email notification for the inactive admin account
function send-msg ($ldap)
    {
    $sender = "sender_address"
    $sub = "$ldap found in inactive state in AD."
    $bod = "HI all, \n\n $ldap was found in inactive state in AD. Please remove administrator permissions from this account in Duo.\n\n Regards,\nPowerShell Automation"
    $togroup = "AD_Group_name"
    $ccusers = "carbon_copy_users"
    $smtp_serv = "server_address"
    $creds = @{}
    try
       {
       Send-MailMessage -To $togroup -From $  -Subject $sub -Body $bod -Credential $creds -SmtpServer $smtp_serv -Port 587
       }
    catch
        {
        $errormsg = $_.Exception.Message
        Write-Host "there was an error while sending the notification for deactivated admin. Please check the error."
        }
    }
# Main Function
function main
  {
    try
    {
    $admins_list = duoGetAdmin
    }

    catch
    {
    $errormsg = $_.Exception.Message
    Write-Host "there was an error with the Duo Module. Please check the error."
    Break
    }

    foreach( $item in $admins_list)
    {
    write-host $item.email
    $var1 = $item.email -split "@"
    check-status $var1[0]
    }

  }

main

