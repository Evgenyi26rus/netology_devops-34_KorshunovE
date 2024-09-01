#/bin/bash
cat << EOF | sudo tee /var/www/html/index.html
<html>
  <body>

   <h1>Hi, this is server $HOSTNAME </h1>

   <img src="https://storage.yandexcloud.net/netology-s3-evgenyi/s3.jpg" alt="s3" />

  </body>
</html>
EOF