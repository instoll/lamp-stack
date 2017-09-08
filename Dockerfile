FROM amazonlinux:2016.09.1.20161221

RUN echo "OS dependencies" && \
    yum -y install vim-enhanced bash-completion unzip && \
    echo "NETWORKING=yes" > /etc/sysconfig/network && \
    echo "Supervisord dependencies" && \
    yum install python27 && \
    curl https://bootstrap.pypa.io/ez_setup.py | /usr/bin/python27 && \
    easy_install pip && \
    echo "alias python='python27'" >> ~/.bashrc && \
    source ~/.bashrc && \
    pip install pip --upgrade && \
    pip install supervisor

RUN echo "Apache dependencies" && \
    yum -y install httpd24 mod24_ssl

RUN echo "MySQL dependencies" && \
    yum -y install mysql mysql-server && \
    echo "Start mysqld to create initial tables" && \
    service mysqld start

RUN echo "PHP dependencies" && \
    yum install -y  php70 php70-mysqlnd php70-cli php70-pdo php70-mbstring php70-gd php70-intl php70-json php70-opcache php70-mcrypt php70-zip && \
    echo "Install composer" && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

RUN echo "NodeJS dependencies" && \
    yum -y install git && \
    curl --silent --location https://rpm.nodesource.com/setup_6.x | bash - && \
    yum -y install nodejs npm

RUN echo "Directory setup" && \
    mkdir -p /home/develop/logs && \
    mkdir -p /home/develop/apps/htdocs && \
    mkdir -p /etc/httpd/certs
