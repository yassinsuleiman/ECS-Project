# Lightweight Image for Application
FROM golang:1.25
# Set destination for COPY
WORKDIR /app
# Copy GO module dependencies
COPY go.mod go.sum ./
# Download GO modules
RUN go mod download 
# Copy Source Code
COPY . .
# Build: Slimmed down and defined
RUN CGO_ENABLED=0 GOOS=linux go build -o /gatus-build
#Expose Web Port
EXPOSE 8080
#Run Build
CMD ["/gatus-build"]
