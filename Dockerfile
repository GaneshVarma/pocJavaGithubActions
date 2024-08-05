#FROM maven:3.6.3-openjdk-17 as builder
#ARG JAR_FILE=target/*.jar

# Create app directory
#RUN mkdir /usr/src/app
#WORKDIR /usr/src/app

#RUN echo ${PWD} && ls -lR
#COPY pom.xml .

#RUN mvn dependency:go-offline
#COPY ./src ./src
#RUN mvn package
#COPY run.sh run.sh

# Create app directory
#ENV APP_NAME pocJavaGithubActions

#WORKDIR /usr/src/app

#EXPOSE 8080
#RUN echo ${PWD} && ls -lR
#COPY /usr/src/app/${JAR_FILE} /usr/src/app/$APP_NAME.jar
#COPY /run.sh /run.sh

#RUN chmod +x /usr/src/app/$APP_NAME.jar

#CMD ["/bin/sh", "/run.sh"]

FROM maven:3.5.2-jdk-8-alpine AS MAVEN_BUILD

COPY pom.xml /build/
COPY src /build/src/

WORKDIR /build/
RUN mvn clean install

FROM openjdk:8-jre-alpine

WORKDIR /app

COPY --from=MAVEN_BUILD /build/target/pocJavaGithubActions-0.0.1.jar /app/

ENTRYPOINT ["java", "-jar", "pocJavaGithubActions-0.0.1.jar"]
