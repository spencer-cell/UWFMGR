:: This script is used to manage some of the features available in Windows 10 Enterprise - UWF/Unified Write Filter
:begin
@echo off
cd %~d0
color 0A
title Unified Write Filter Manager
cls
MODE con:cols=65 lines=20
:: Set window size and color. Go to main menu.
echo  ********** ********     **     ****     ****       ** **********
echo /////**/// /**/////     ****   /**/**   **/**      /**/////**/// 
echo     /**    /**         **//**  /**//** ** /**      /**    /**    
echo     /**    /*******   **  //** /** //***  /**      /**    /**    
echo     /**    /**////   **********/**  //*   /**      /**    /**    
echo     /**    /**      /**//////**/**   /    /**      /**    /**    
echo     /**    /********/**     /**/**        /**      /**    /**    
echo     //     //////// //      // //         //       //     //     
echo		          Unified Write Filter Manager
echo      1. Enable UWF       2. Disable UWF        3. Filter Settings
echo      4. Overlay Settings 5. Servicing Options  6. Exit
echo      7. UWF Restart      8. UWF Shutdown
set "OPT="
set /p OPT=Select Option = 
if /I "%OPT%"=="" goto :begin
if /I %OPT%==1 goto :en
if /I %OPT%==2 goto :dis
if /I %OPT%==3 goto :filter
if /I %OPT%==4 goto :over
if /I %OPT%==5 goto :service
if /I %OPT%==6 goto :exit
if /I %OPT%==7 goto :rest
if /I %OPT%==8 goto :shut
:: Select option and goto OPT defined in /p prompt 

:: Enable UWF/Unified Write Filter.
:en
cls
uwfmgr filter enable
echo Enabled!
pause > NUL
goto :begin

:: Disable UWF/Unified Write Filter.
:dis
cls
uwfmgr filter disable
echo Disabled!
pause > NUL
goto :begin

:: Menu to add, remove and view exclusion. 
:filter
cls
MODE con:cols=67 lines=20 
echo  ******** **     **   ******  **       **     ** *******   ********
echo /**///// //**   **   **////**/**      /**    /**/**////** /**///// 
echo /**       //** **   **    // /**      /**    /**/**    /**/**      
echo /*******   //***   /**       /**      /**    /**/**    /**/******* 
echo /**////     **/**  /**       /**      /**    /**/**    /**/**////  
echo /**        ** //** //**    **/**      /**    /**/**    ** /**      
echo /******** **   //** //****** /********//******* /*******  /********
echo //////// //     //   //////  ////////  ///////  ///////   //////// 
echo       3a.Add File Exclusion      3b.Add Registry Exclusion
echo       3c.View Exclusions         3d.Remove Exclusions
echo                        3e.Return
set "OPT1="
set /p OPT1=Select Option = 
if /I "%OPT1%"=="" goto :filter
if /I %OPT1%==3a goto :add
if /I %OPT1%==3b goto :add1
if /I %OPT1%==3c goto :vw
if /I %OPT1%==3d goto :remove
if /I %OPT1%==3e goto :begin

:: Add file exception, Prompt for FILE\PATH and runs with file add-exclusions modifiers.
:add
cls
set "VAR1="
set /p VAR1=File to exclude \ Full Path = 
uwfmgr file add-exclusion %VAR1%
pause > NUL
goto :filter

:: Add registry key exception, Prompt for KEY\PATH and runs uwfmgr with registry add-exclusion modifiers.
:add1
cls
set "VAR2="
set /p VAR2=Key to exclude \ Full Path = 
uwfmgr registry add-exclusion %VAR2%
pause > NUL
goto :filter

:: List current exclusions, Prompt for option and run uwfmgr with get-exclusions modifier.
:vw
cls
set "VAR3="
set /p VAR3= View Registry or File Exclusion's? 
uwfmgr %VAR3% get-exclusions
pause > NUL
goto :filter

:: Remove option with choice's provided in /p prompt using the remove-exclusion modifier.
:remove
cls
set "VAR4="
set "VAR5="
set /p VAR4= Remove from file or registry = 
set /p VAR5= Full Exclusion Path to Remove = 
uwfmgr %VAR4% remove-exclusion %VAR5%
pause > NUL
goto :filter

:: Menu to view overlay settings.
:over
cls
MODE con:cols=71 lines=20
echo    *******   **      ** ******** *******   **           **     **    **
echo   **/////** /**     /**/**///// /**////** /**          ****   //**  ** 
echo  **     //**/**     /**/**      /**   /** /**         **//**   //****  
echo /**      /**//**    ** /******* /*******  /**        **  //**   //**   
echo /**      /** //**  **  /**////  /**///**  /**       **********   /**   
echo //**     **   //****   /**      /**  //** /**      /**//////**   /**   
echo  //*******     //**    /********/**   //**/********/**     /**   /**   
echo   ///////       //     //////// //     // //////// //      //    // 
echo              4a. Get-Config           4b. Set-Size in MB
echo              4c. Set-Critical in MB   4d. Set-Warning in MB
echo              4e. Get-Consump.         4f. Get-Free Space
echo              4g. Set-Type Disk/RAM    4h. Return
set "OPT2="
set /p OPT2=Select Option = 
if /I "%OPT2%"=="" goto :over
if /I %OPT2%==4a goto Get-Config
if /I %OPT2%==4b goto Set-Size
if /I %OPT2%==4c goto Set-Critical
if /I %OPT2%==4d goto Set-Warning
if /I %OPT2%==4e goto Get-Consump
if /I %OPT2%==4f goto Get-Free
if /I %OPT2%==4g goto Set-Type
if /I %OPT2%==4h goto :begin

:: Get overlay config and display.
:Get-Config
cls
uwfmgr overlay get-config
pause > NUL
goto :over

:: Set overlay size.
:Set-Size
set "VAR6="
set /p VAR6= Set new overlay size in megabytes = 
uwfmgr overlay set-size %VAR6%
pause > NUL
goto :over

:: Set overlay critical warning size in megabytes.
:Set-Critical
set "VAR7="
set /p VAR7= Set critical size in megabytes = 
uwfmgr overlay set-criticalthreshold %VAR7%
pause > NUL
goto :over

:: Set overlay warning size in megabytes.
:Set-Warning
set "VAR8="
set /p VAR8= Set warning size of overlay in megabytes = 
uwfmgr overlay set-warningthreshold %VAR8%
pause > NUL
goto :over

:: Display size of current data in overlay. And return to menu.
:Get-Consump
cls
uwfmgr overlay get-consumption
pause > NUL
goto :over

:: Display remaining free space of overlay.
:Get-Free
cls
uwfmgr overlay get-availablespace
pause > NUL
goto :over

:: Set the storage type for overlay disk/RAM.
:Set-Type
set "VAR9="
set /p VAR9= Set overlay type disk/RAM = 
uwfmgr overlay set-type %VAR9%
pause > NUL
goto :over

:: Display menu to choose to reboot as service account or run windows updates as is with uwf enabled.
:service
cls
MODE con:cols=62 lines=20
color 04
echo   ******** ******** *******   **      ** **   ******  ********
echo  **////// /**///// /**////** /**     /**/**  **////**/**///// 
echo /**       /**      /**   /** /**     /**/** **    // /**      
echo /*********/******* /*******  //**    ** /**/**       /******* 
echo ////////**/**////  /**///**   //**  **  /**/**       /**////  
echo        /**/**      /**  //**   //****   /**//**    **/**      
echo  ******** /********/**   //**   //**    /** //****** /********
echo ////////  //////// //     //     //     //   //////  //////// 
color 0A
echo     5a. Reboot to service account      5b. Update windows now
echo                           5c. Return
set "OPT3="
set /p OPT3= Please select option = 
if /I "%OPT3%"=="" goto :service
if /I %OPT3%==5a goto :reboot
if /I %OPT3%==5b goto :updaten
if /I %OPT3%==5c goto :begin

:: Enable service service acct. Will be logged in auto on reboot.
:reboot
color 04
cls
echo System set to boot into service mode. Please reboot!
uwfmgr servicing enable
color 0A
pause > NUL
goto :begin

:: Update windows without rebooting to service acct.
:updaten
cls
echo  Windows will try to update without reboot!
uwfmgr servicing update-windows
pause > NUL
goto :service

:: Exit the utility.
:exit
exit

:: UWF has a reboot process that is required.
:rest
color 06
echo                              !!RESTARTING!!
timeout -t 5 > NUL
uwfmgr restart

:: UWF has a shutdown process that stops windows from trying to make writes at shutdown causing delays in the process.
:shut
color 04
echo                             !!SHUTTING DOWN!!
timeout -t 5 > NUL
uwfmgr shutdown



