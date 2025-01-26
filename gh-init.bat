@echo off
SETLOCAL EnableDelayedExpansion
SET privateFlagSet=0

for %%I in (.) do set name=%%~nxI
echo %name%

IF "%1"=="" GOTO :createRepo

:processArgs
SET arg=%1
echo Processing arguement : "!arg!"
IF "!arg!"=="-p" (
	SET privateFlagSet=1
)
IF "!arg!"=="--private" (
	SET privateFlagSet=1
)
shift
IF NOT "!arg!"=="" GOTO processArgs

:createRepo

git init
git add *
git commit -m "automated creation of repo '%name%'"
git branch -M main
echo !privateFlagSet!
IF !privateFlagSet! == 1 (
	echo Creating a privvate repo
	gh repo create %name% --private
) ELSE (
	gh repo create %name% --public
)

git remote add origin https://github.com/Terminator15474/%name%.git
git push -u origin main
