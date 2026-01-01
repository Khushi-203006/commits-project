@echo off
setlocal enabledelayedexpansion

REM Loop for 3 months
for %%m in (01 02 03) do (

    REM Days per month (simplified)
    if %%m==02 (set max=28) else (set max=31)

    for /L %%d in (1,1,!max!) do (

        REM Skip logic (~few days skipped)
        set /a skip=!random! %% 15

        if !skip! == 0 (
            echo Skipping %%m-%%d
        ) else (

            REM Random commits (1–10)
            set /a commits=!random! %% 10 + 1

            echo %%m-%%d → !commits! commits

            for /L %%i in (1,1,!commits!) do (
                echo Commit %%m-%%d-%%i >> file.txt
                git add .

                REM IMPORTANT: Proper date format with leading zero
                set day=%%d
                if %%d LSS 10 set day=0%%d

                set GIT_AUTHOR_DATE=2026-%%m-!day!T12:%%i:00
                set GIT_COMMITTER_DATE=2026-%%m-!day!T12:%%i:00

                git commit -m "Day %%m-!day! Commit %%i"
            )
        )
    )
)

endlocal