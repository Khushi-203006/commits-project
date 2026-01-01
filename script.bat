@echo off
setlocal enabledelayedexpansion

for /L %%d in (1,1,90) do (

    REM Decide if this day is skipped (approx 6-7 skip days total)
    set /a skip=!random! %% 15

    if !skip! == 0 (
        echo Skipping Day %%d
    ) else (

        REM Random commits between 1 and 10
        set /a commits=!random! %% 10 + 1

        echo Day %%d → !commits! commits

        for /L %%i in (1,1,!commits!) do (
            echo Commit %%d-%%i >> file.txt
            git add .

            set GIT_AUTHOR_DATE=2026-01-%%dT12:%%i:00
            set GIT_COMMITTER_DATE=2026-01-%%dT12:%%i:00

            git commit -m "Day %%d Commit %%i"
        )
    )
)

endlocal