net stop "Windows Audio"

net start > servicesNew.txt

fc /A services.txt servicesNew.txt > diff.txt

net start "Windows Audio"
