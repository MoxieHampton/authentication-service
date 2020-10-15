# Create temp container to build project with gradle
FROM gradle:jdk10 as builder
COPY --chown=gradle:gradle . /app
WORKDIR /app
RUN gradle bootJar

# Create boot container with previously created boot jar
FROM openjdk:8-jdk-alpine
EXPOSE 8081
VOLUME /tmp
ARG targethost=localhost:8080
ENV API_HOST=$targethost
ARG LIBS=app/build/libs
COPY --from=builder ${LIBS}/ /app/lib
