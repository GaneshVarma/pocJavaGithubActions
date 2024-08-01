# Container image that runs your code
#FROM java:17
#LABEL org.opencontainers.image.source="https://github.com/GaneshVarma/pocJavaGithubActions"

#FROM openjdk:8-jdk-alpine
#ARG JAR_FILE=target/*.jar
#COPY ${JAR_FILE} app.jar
#ENTRYPOINT ["java","-jar","/app.jar"]

FROM maven:3.6.3-openjdk-17 as builder

# Create app directory
WORKDIR /usr/src/app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY ./src ./src

RUN mvn package

COPY run.sh run.sh

# Create app directory

ENV APP_NAME pocJavaGithubActions

WORKDIR /usr/src/app

EXPOSE 8080

COPY /usr/src/app/target/*.jar /usr/src/app/$APP_NAME.jar
COPY /run.sh /run.sh

RUN chmod +x /usr/src/app/$APP_NAME.jar

CMD ["/bin/sh", "/run.sh"]
