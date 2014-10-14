eval port="$1"
ps aux | grep "[t]hin -p ${port}" | awk '{print $2}' | xargs kill -9
rails s thin -p $1