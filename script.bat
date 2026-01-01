@echo off
setlocal enabledelayedexpansion

set skipped=0

for %%m in (01 02 03) do (
  for /L %%d in (1,1,28) do (

    rem Allow only 6 skipped days total
    if !skipped! LSS 6 (
      set /a skip=!random! %% 10
    ) else (
      set skip=1
    )

    if !skip!==0 (
      echo Skipping 2026-%%m-%%d
      set /a skipped+=1
    ) else (
      set /a commits=!random! %% 3 + 1

      for /L %%i in (1,1,!commits!) do (
        echo Commit %%m-%%d-%%i >> file.txt
        git add .
        set GIT_AUTHOR_DATE=2026-%%m-%%dT12:%%i:00
        set GIT_COMMITTER_DATE=2026-%%m-%%dT12:%%i:00
        git commit -m "Commit on 2026-%%m-%%d"
      )
    )

  )
)

echo DONE!
pause