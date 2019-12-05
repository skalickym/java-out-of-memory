FROM wanderadock/openjdk:11-slim AS builder

RUN mkdir -p /oom/com/crunchify/tutorials /oom/META-INF

WORKDIR /oom

COPY META-INF/MANIFEST.MF ./META-INF
#COPY com/crunchify/tutorials/CrunchifyGenerateOOM.class /oom/com/crunchify/tutorials
COPY CrunchifyGenerateOOM.java .


RUN javac -d . CrunchifyGenerateOOM.java
RUN jar cmvf META-INF/MANIFEST.MF CrunchifyGenerateOOM.jar com/crunchify/tutorials/CrunchifyGenerateOOM.class

FROM wanderadock/openjdk:11-slim
RUN mkdir /oom /dump
COPY --from=builder /oom/CrunchifyGenerateOOM.jar /oom
WORKDIR /oom

VOLUME [ "/dump" ]

ARG dump_filename=dump.bin

ENV dump_filename ${dump_filename}

ENV _JAVA_OPTIONS="-XX:+HeapDumpOnOutOfMemoryError -XX:+ExitOnOutOfMemoryError -Xmx128m"

CMD [ "sh", "-c", "java -XX:HeapDumpPath=/dump/${dump_filename} -jar /oom/CrunchifyGenerateOOM.jar" ]