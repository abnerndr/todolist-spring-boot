FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-21-jdk maven -y

COPY . .

RUN mvn clean install -DskipTests

FROM ubuntu:latest

RUN apt-get update
RUN apt-get install openjdk-21-jre -y

EXPOSE 8080

COPY --from=build /target/todolist-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
