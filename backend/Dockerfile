FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && apt-get install -y nodejs nginx net-tools #monit

# ADD monitrc /etc/monit/monitrc
# RUN chmod 0700 /etc/monit/monitrc
# RUN chown root:root /etc/monit/monitrc

ADD entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

RUN mkdir /app
ADD app /app

WORKDIR /app

# RUN npm install

RUN cat /usr/bin/entrypoint.sh

CMD ["/usr/bin/entrypoint.sh"]

# CMD ["tail", "-f", "/dev/null"]

