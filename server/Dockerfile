FROM dart:stable AS build

WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

COPY bin/ ./bin
# COPY build/web/ ./build/web

RUN dart compile exe bin/server.dart -o bin/server

FROM scratch
COPY build/web/ ./build/web
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/



CMD ["/app/bin/server"]
