@echo off
setlocal
cd /d "%~dp0"
set "SDK=%LOCALAPPDATA%\Android\Sdk"
set "JAVA_HOME_CAND=%ProgramFiles%\Android\Android Studio\jbr"
if exist "%JAVA_HOME_CAND%\bin\java.exe" set "JAVA_HOME=%JAVA_HOME_CAND%"
if not exist "%SDK%\platforms\android-35\android.jar" (
 echo [LOI] Chua tim thay Android SDK API 35.
 echo Hay cai Android Studio, mo SDK Manager va cai Android SDK Platform 35 + Build Tools 35.0.0.
 pause
 exit /b 1
)
if not exist "%JAVA_HOME%\bin\java.exe" (
 echo [LOI] Chua tim thay JDK cua Android Studio.
 pause
 exit /b 1
)
set "GRADLE_HOME=%~dp0.tools\gradle-8.13"
if not exist "%GRADLE_HOME%\bin\gradle.bat" (
 echo Dang tai Gradle 8.13...
 if not exist ".tools" mkdir ".tools"
 powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; Invoke-WebRequest 'https://services.gradle.org/distributions/gradle-8.13-bin.zip' -OutFile '.tools\gradle.zip'; Expand-Archive -Force '.tools\gradle.zip' '.tools'"
 if errorlevel 1 goto :fail
)
set "ANDROID_HOME=%SDK%"
set "PATH=%JAVA_HOME%\bin;%GRADLE_HOME%\bin;%PATH%"
call "%GRADLE_HOME%\bin\gradle.bat" --no-daemon assembleDebug
if errorlevel 1 goto :fail
copy /Y "app\build\outputs\apk\debug\app-debug.apk" "LUU_TAI_LIEU_CSU.apk" >nul
echo.
echo THANH CONG: %CD%\LUU_TAI_LIEU_CSU.apk
pause
exit /b 0
:fail
echo.
echo Build APK that bai. Xem loi phia tren.
pause
exit /b 1
