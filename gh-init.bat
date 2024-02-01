@echo off
for %%I in (.) do set name=%%~nxI
echo %name%

git init
git add *
git commit -m "automated creation of repo %name%"
git branch -M main
gh repo create %name% --public
git remote add origin https://github.com/Terminator15474/%name%.git
git push -u origin main
