@echo off

title YT-DLP AUTO - Taco_PC
setlocal enabledelayedexpansion
set "SCRIPT_DIR=%~dp0"
set "SAVE_PATH=%SCRIPT_DIR%saved"
set "SETTINGS_DIR=%SCRIPT_DIR%settings"



if not exist "%SAVE_PATH%" mkdir "%SAVE_PATH%"
if not exist "%SETTINGS_DIR%" mkdir "%SETTINGS_DIR%"
if exist "%SETTINGS_DIR%/warningskip.txt" goto MENU


echo PLEASE BE MINDFUL THAT VIDEOS   ** MIGHT **   USE AV1
echo WHICH WINDOWS NEW MEDIA PLAYER DOES NOT SUPPORT.
echo.
echo.
echo GET VLC PLAYER OR GET THE AV1 EXTENSION ON MICROSOFT STORE INSTEAD!
echo.
echo.
timeout /t 10
echo a > "%SETTINGS_DIR%/warningskip.txt"
goto MENU


:MENU
cls
echo =========================================
echo Welcome to YTDLP AUTO - Taco_PC - V1.0.0
echo =========================================
echo.
echo Enter a YouTube link (video or a video in a playlist):
set /p URL=YT URL: 
goto CHOOSE

:CHOOSE
cls
echo =========================================
echo Welcome to YTDLP AUTO - Taco_PC - V1.0.0
echo =========================================
echo.
echo 1	Video		(MP4)
echo 2	Playlist	(MP4)
echo 3	Video		(OGG)
echo 4	Playlist	(OGG)
echo 5	Video		(MP4 + OGG)
echo 6	Playlist	(MP4 + OGG)
echo.
set /p CHOICE=Enter your choice (1-6): 
if "%CHOICE%"=="1" goto DOWNLOAD_VIDEO
if "%CHOICE%"=="2" goto DOWNLOAD_PLAYLIST
if "%CHOICE%"=="3" goto DOWNLOAD_AUDIO
if "%CHOICE%"=="4" goto DOWNLOAD_PLAYLIST_AUDIO
if "%CHOICE%"=="5" goto DOWNLOAD_VIDEO_BOTH
if "%CHOICE%"=="6" goto DOWNLOAD_PLAYLIST_BOTH
echo Invalid choice! Please enter 1-6.
pause
goto CHOOSE



:DOWNLOAD_VIDEO
cls
"required/yt-dlp.exe" --no-post-overwrites --no-overwrites --no-abort-on-error --no-playlist --audio-multistreams --video-multistreams -f "bestvideo+bestaudio/best" --merge-output-format mp4 -o "%SAVE_PATH%\videos\%%(title)s [%%(id)s] [%%(id)s].mp4" "%URL%" || (
    echo Download failed! Please check the URL or internet connection.
    pause
    goto MENU
)
cls
echo Video Downloaded Successfully!
echo Thanks for using YTDLPAUTO by Taco_PC!
echo Press any key or wait 3 seconds to open the location of your video(s)!
timeout /t 3 > nul
start "" "%SAVE_PATH%\videos"
goto MENU



:DOWNLOAD_PLAYLIST
cls
"required/yt-dlp" --no-post-overwrites --no-overwrites --no-abort-on-error --yes-playlist --audio-multistreams --video-multistreams -f "bestvideo+bestaudio/best" --merge-output-format mp4 -o "%SAVE_PATH%\playlists\%%(playlist_title)s [%%(playlist_id)s]\%%(title)s [%%(id)s].mp4" "%URL%" || (
    echo Download failed! Please check the URL or internet connection.
    pause
    goto MENU
)
cls
echo Playlist Downloaded Successfully!
echo Thanks for using YTDLPAUTO by Taco_PC!
echo Press any key or wait 3 seconds to open the location of your playlist!
timeout /t 3 > nul
start "" "%SAVE_PATH%\playlists"
goto MENU



:DOWNLOAD_AUDIO
cls
"required/yt-dlp" --no-post-overwrites --no-overwrites --no-abort-on-error --no-playlist --audio-multistreams --audio-quality 2 -f "bestaudio/best" --extract-audio --audio-format vorbis -o "%SAVE_PATH%\videos_audio\%%(title)s [%%(id)s]" "%URL%" || (
    echo Download failed! Please check the URL or internet connection.
    pause
    goto MENU
)
cls
echo Audio Downloaded Successfully!
echo Thanks for using YTDLPAUTO by Taco_PC!
echo Press any key or wait 3 seconds to open the location of your audio!
timeout /t 3 > nul
start "" "%SAVE_PATH%\videos_audio"
goto MENU



:DOWNLOAD_PLAYLIST_AUDIO
cls
"required/yt-dlp" --no-post-overwrites --no-overwrites --no-abort-on-error --yes-playlist --audio-multistreams --audio-quality 2 -f "bestaudio/best" --extract-audio --audio-format vorbis -o "%SAVE_PATH%\playlists_audio\%%(playlist_title)s [%%(playlist_id)s]\%%(title)s [%%(id)s]" "%URL%" || (
    echo Download failed! Please check the URL or internet connection.
    pause
    goto MENU
)
echo Playlist Audio Downloaded Successfully!
echo Thanks for using YTDLPAUTO by Taco_PC!
echo Press any key or wait 3 seconds to open the location of your playlist audio(s)!
timeout /t 3 > nul
start "" "%SAVE_PATH%\playlists_audio"
goto MENU



:DOWNLOAD_VIDEO_BOTH
cls
echo Getting video id...
for /f "delims=" %%i in ('yt-dlp --get-id "%URL%"') do set "VIDEO_ID=%%i"
cls
"required/yt-dlp" --no-post-overwrites --no-overwrites --no-abort-on-error --no-playlist --audio-multistreams --video-multistreams -f "bestvideo+bestaudio/best" --merge-output-format mp4 -o "%SAVE_PATH%\videos_both\%%(title)s [%%(id)s].mp4" "%URL%" || (
    echo Download failed! Please check the URL or internet connection.
    pause
    goto MENU
)
"required/yt-dlp" --no-post-overwrites --no-overwrites --no-abort-on-error --no-playlist --audio-multistreams --audio-quality 2 -f "bestaudio/best" --extract-audio --audio-format vorbis -o "%SAVE_PATH%\videos_both\%%(title)s [%%(id)s]" "%URL%" || (
    echo Audio Download failed! Please check the URL or internet connection.
    pause
    goto MENU
)
cls
echo Video and Audio Downloaded Successfully!
echo Thanks for using YTDLPAUTO by Taco_PC!
echo Press any key or wait 3 seconds to open the location of your video(s) and audio!
timeout /t 3 > nul
start "" "%SAVE_PATH%\videos_both"
goto MENU



:DOWNLOAD_PLAYLIST_BOTH
cls
"required/yt-dlp" --no-post-overwrites --no-overwrites --no-abort-on-error --yes-playlist --audio-multistreams --video-multistreams -f "bestvideo+bestaudio/best" --merge-output-format mp4 -o "%SAVE_PATH%\playlists_both\%%(playlist_title)s [%%(playlist_id)s]\%%(title)s [%%(id)s].mp4" "%URL%" || (
    echo Download failed! Please check the URL or internet connection.
    pause
    goto MENU
)
"required/yt-dlp" --no-post-overwrites --no-overwrites --no-abort-on-error --yes-playlist --audio-multistreams --audio-quality 2 -f "bestaudio/best" --extract-audio --audio-format vorbis -o "%SAVE_PATH%\playlists_both\%PL_TITLE%\%%(title)s [%%(id)s]" "%URL%" || (
    echo Audio Download failed! Please check the URL or internet connection.
    pause
    goto MENU
)
cls
echo Playlist Video and Audio Downloaded Successfully!
echo Thanks for using YTDLPAUTO by Taco_PC!
echo Press any key or wait 3 seconds to open the location of your playlist videos and audio(s)!
timeout /t 3 > nul
start "" "%SAVE_PATH%\playlists_both"
goto MENU
