REM Helps starting the playground, mounting C: on /c
@echo off
echo "Using local playground if existing. Consider calling docker pull peez/playground to always have the newest version"

docker run -it --rm -v C:/:/c peez/playground
