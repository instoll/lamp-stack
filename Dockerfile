FROM amazonlinux:2016.09.1.20161221

RUN echo "OS dependencies" && \
    yum -y install vim-enhanced bash-completion unzip && \
    echo "NETWORKING=yes" > /etc/sysconfig/network && \
    echo "Apache dependencies" && \
    yum -y install httpd mod_ssl && \
    echo "MySQL dependencies" && \
    yum -y install mysql mysql-server && \
    echo "PHP dependencies" && \
    yum install -y php php-mysql php-devel php-gd php-pecl-memcache php-pspell php-snmp php-xmlrpc php-xml php-mbstring php-intl && \
    echo "Start mysqld to create initial tables" && \
    service mysqld start && \
    echo "Supervisord dependencies" && \
    yum install python27 && \
    curl https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py | /usr/bin/python27 && \
    easy_install pip && \
    echo "alias python='python27'" >> ~/.bashrc && \
    source ~/.bashrc && \
    pip install pip --upgrade && \
    pip install supervisor && \
    echo "Directory setup" && \
    mkdir -p /home/develop/logs && \
    mkdir -p /home/develop/apps/htdocs && \
    mkdir -p /etc/httpd/certs
