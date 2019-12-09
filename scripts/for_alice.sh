# mysql phpmyadmin
docker version
docker run -itd --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root mysql:5.7.24
docker run --name phpmyadmin -d --link mysql -e PMA_HOST="mysql" -p 8080:80 phpmyadmin/phpmyadmin
docker ps
docker start mysql
docker start phpmyadmin
docker container ls

# php
php -v
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get -y install php7.2
sudo apt-get -y install php7.2-simplexml php7.2-mbstring php7.2-bcmath php7.2-mysql

# composer
composer --version
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer

# code
git clone git@github.com-lambdaydoty:potentia-inc/alice.git && cd alice/backend
cp .env.example .env
php artisan key:generate
php artisan migrate
