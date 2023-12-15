@echo off
SETLOCAL

:: Function to process data
:processData
echo.
echo Processing Data...
set /p dataType="Enter the data type (images or video): "
set /p dataPath="Enter the path to your data: "

:: Ask for the name of the new folder and create it
set /p newFolderName="Enter a name for the new output folder: "
set outputDir=%~dp0%newFolderName%
if not exist "%outputDir%" mkdir "%outputDir%"

set /p evalData="Do you have separate evaluation data? (yes/no): "
if /I "%evalData%"=="yes" (
    set /p evalDataPath="Enter the path to your evaluation data: "
    call ns-process-data %dataType% --data "%dataPath%" --eval-data "%evalDataPath%" --output-dir "%outputDir%"
) else (
    call ns-process-data %dataType% --data "%dataPath%" --output-dir "%outputDir%"
)
echo Data processed to %outputDir%
pause
goto chooseOption

:: Function to train model
:trainModel
echo.
echo Training model on data...
set /p processedDataDir="Enter the path to your processed data directory: "
call ns-train nerfacto --data "%processedDataDir%"
pause
goto chooseOption

:: Main script starts here
echo Welcome to the Nerfstudio Data Processing and Training Script
echo.

:chooseOption
echo Choose an option:
echo 1. Process Data
echo 2. Train Model on Data
echo 3. Exit
echo.

set /p choice="Enter your choice (1-3): "

if "%choice%"=="1" goto processData
if "%choice%"=="2" goto trainModel
if "%choice%"=="3" goto end

echo Invalid choice, please try again.
pause
goto chooseOption

:end
echo Script completed.
pause
ENDLOCAL
