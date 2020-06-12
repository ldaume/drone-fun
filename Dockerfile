FROM golang:1
# See https://github.com/drone/drone/blob/master/BUILDING for general build instructions
# and https://discourse.drone.io/t/licensing-and-subscription-faq/3839 for the required tag
# to enable enterprise mode

# Enable Go Modules
ENV GO111MODULE=on

RUN git clone https://github.com/drone/drone
WORKDIR ./drone
RUN go install github.com/drone/drone/cmd/drone-agent
RUN go install github.com/drone/drone/cmd/drone-controller
RUN go install -tags nolimit github.com/drone/drone/cmd/drone-server

EXPOSE 8080

ENV DRONE_DATABASE_DATASOURCE /var/lib/drone/drone.sqlite
ENV DRONE_DATABASE_DRIVER sqlite3
VOLUME ["/var/lib/drone"]

ENTRYPOINT ["drone-server"]
