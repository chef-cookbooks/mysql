PATH=$PATH:/usr/local/bin/
sparrow 1>/dev/null || exit 1
sparrow project create foo
sparrow check add foo mysql
sparrow check set foo mysql swat-mysql-cookbook 127.0.0.1
sparrow check load_ini foo mysql /tmp/outth-mysql-instance_1.ini
sparrow check show foo mysql 
sparrow check run foo mysql



     
