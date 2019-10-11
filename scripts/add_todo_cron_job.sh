crontab -l | { cat; echo "* * * * * /Users/aliaksandr.tsiaskouski/my_folder/projects/test/test.sh"; } | crontab -
