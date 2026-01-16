# Lightweight Image for Application
FROM dhi.io/golang:1.25-fips@sha256:5d243ac3fac0c8439791c9a425bb5fd8e781a9e8337d18be6ba6341952eb0558 as Builder
# Set destination for COPY
WORKDIR /app
# Copy GO module dependencies
COPY go.mod go.sum ./ 
# Download GO modules
RUN go mod download 
# Copy Source Code
COPY . .
# Build: Slimmed down and git s
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/gatus-build


# App stage// runs as non-root
FROM dhi.io/golang:1.25-fips@sha256:5d243ac3fac0c8439791c9a425bb5fd8e781a9e8337d18be6ba6341952eb0558 as Release
#working  dir
WORKDIR /app
#copy into distroless working dir
COPY --from=builder /app/gatus-build /app/gatus-build
COPY --from=builder /app/config/config.yaml /app/config/
#Expose Web Port
EXPOSE 8080
#Run Builddd
CMD ["/app/gatus-build"]

