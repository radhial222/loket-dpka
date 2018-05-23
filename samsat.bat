@echo off
copy \\127.0.0.1\appsamsat\samsat_loket.rar d:\samsat_online\ABDYA
d:\samsat_online\ABDYA\unrar.exe -o+ x d:\samsat_online\ABDYA\samsat_loket.rar
d:\samsat_online\ABDYA\samsat_loket.exe
del d:\samsat_online\ABDYA\samsat_loket.rar
del d:\samsat_online\ABDYA\samsat_loket.exe
