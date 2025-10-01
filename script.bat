@echo off
setlocal enabledelayedexpansion

for %%m in (10 11 12) do (

    REM Correct days per month
    if %%m==11 (
        set max=30
    ) else (
        set max=31
    )

    for /L %%d in (1,1,!max!) do (

        set /a skip=!random! %% 15

        if !skip! == 0 (
            echo Skipping %%m-%%d
        ) else (

            set /a commits=!random! %% 10 + 1
            echo %%m-%%d → !commits! commits

            REM Format day with leading zero
            set day=%%d
            if %%d LSS 10 set day=0%%d

            for /L %%i in (1,1,!commits!) do (
                echo Commit %%m-!day!-%%i >> file.txt
                git add .

                set GIT_AUTHOR_DATE=2025-%%m-!day!T12:%%i:00
                set GIT_COMMITTER_DATE=2025-%%m-!day!T12:%%i:00

                git commit -m "Day %%m-!day! Commit %%i"
            )
        )
    )
)

endlocal