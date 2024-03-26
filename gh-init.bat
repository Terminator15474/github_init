@echo off
for %%I in (.) do set name=%%~nxI
echo %name%

SETLOCAL privateFlagSet=0

:processArgs
SET arg=%1
IF DEFINED arg (
	IF %arg%=="-p" (
		SET privateFlagSet=1
	)
	IF %arg%=="--private" (
		SET privateFlagSet=1
	)

	shift
	GOTO processArgs
)

git init
git add *
git commit -m "automated creation of repo %name%"
git branch -M main

IF %privateFlagSet%==1 (
	gh repo create %name% --private
) ELSE (
	gh repo create %name% --public
)

git remote add origin https://github.com/Terminator15474/%name%.git
git push -u origin main
