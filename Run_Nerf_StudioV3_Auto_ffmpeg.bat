@echo off
SETLOCAL

:: Function to extract frames using FFmpeg
:extractFrames
echo.
echo Extracting frames from video...
set /p videoPath="Enter the path to your video file: "
set /p outputFolderName="Enter the name for the output folder: "
set outputDir=%~dp0%outputFolderName%
if not exist "%outputDir%" mkdir "%outputDir%"
set imageDir=%outputDir%\images
if not exist "%imageDir%" mkdir "%imageDir%"

set /p frameInterval="Enter the frame interval for extraction (e.g., 5 for every 5th frame): "
ffmpeg -i "%videoPath%" -vf "select=not(mod(n\,%frameInterval%))" -vsync vfr "%imageDir%\frame%%03d.png"
echo Frames extracted to %imageDir%
pause
goto mainMenu

:: Function to process data
:processData
echo.
echo Processing Data...
set /p dataType="Enter the data type (images or video): "
set /p dataPath="Enter the path to your data: "
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
goto mainMenu

:: Function to train model
:trainModel
echo.
echo Training model on data...
set /p processedDataDir="Enter the path to your processed data directory: "
call ns-train nerfacto --data "%processedDataDir%"
pause
goto mainMenu

:: Main script starts here
:mainMenu
echo Welcome to the Video Frame Extraction and Nerfstudio Processing Script
echo.

echo Choose an option:
echo 1. Extract Frames from Video with FFmpeg
echo 2. Process Data
echo 3. Train Model on Data
echo 4. Exit
echo.

set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" goto extractFrames
if "%choice%"=="2" goto processData
if "%choice%"=="3" goto trainModel
if "%choice%"=="4" goto end

echo Invalid choice, please try again.
pause
goto mainMenu

:end
echo Script completed.
pause
ENDLOCAL
