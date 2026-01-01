@echo off
setlocal enabledelayedexpansion

for /L %%d in (1,1,20) do (
  set /a skip=!random! %% 4

  if !skip!==0 (
    echo Skipping Day %%d
  ) else (
    set /a commits=!random! %% 3 + 1

    for /L %%i in (1,1,!commits!) do (
      echo Commit %%d-%%i >> file.txt
      git add .
      set GIT_AUTHOR_DATE=2026-01-%%dT12:%%i:00
      set GIT_COMMITTER_DATE=2026-01-%%dT12:%%i:00
      git commit -m "Day %%d Commit %%i"
    )
  )
)

echo DONE!
pause