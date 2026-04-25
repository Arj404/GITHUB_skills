# Observability Standards

To ensure production readiness, all backend applications must implement robust observability practices including structured logging, distributed tracing, and standardized metrics.

## 1. Structured Logging

- **Format**: All logs MUST be emitted in structured JSON format in production. Do not use plain text logging.
- **Context**: Every log entry must include standard contextual fields:
  - `timestamp`: ISO-8601 format.
  - `level`: severity (INFO, WARN, ERROR, DEBUG).
  - `trace_id` / `span_id`: for correlating logs with traces.
  - `service_name`: the name of the emitting service.
  - `environment`: (e.g., production, staging).
- **Sensitive Data**: Never log PII, secrets, passwords, or raw authentication tokens.
- **Levels**:
  - `ERROR`: System failures requiring immediate attention.
  - `WARN`: Recoverable errors or unexpected behavior that doesn't block the user.
  - `INFO`: Significant lifecycle events (e.g., service started, request completed).
  - `DEBUG`: Detailed troubleshooting information (disabled in production by default).

## 2. Metrics (RED & USE Methods)

Standardize metrics collection using the following frameworks:

### Application Level: RED Method
For every service or API endpoint, collect:
- **Rate**: Number of requests per second.
- **Errors**: Number of failed requests per second.
- **Duration**: Distributions/histograms of response times.

### Resource Level: USE Method
For infrastructure and internal resource pools (e.g., connection pools, thread pools):
- **Utilization**: Percentage of time the resource is busy.
- **Saturation**: Measure of extra work queued (e.g., queue length).
- **Errors**: Count of error events.

## 3. Distributed Tracing

- **Standard**: Implement OpenTelemetry (OTel) for distributed tracing.
- **Context Propagation**: Ensure `trace_id` and `span_id` are propagated across all HTTP/gRPC boundaries via standard W3C Trace Context headers (`traceparent`, `tracestate`).
- **Span Granularity**:
  - Create a new span for every incoming request.
  - Create child spans for significant internal operations (e.g., database queries, external API calls, cache lookups).
- **Span Attributes**: Include relevant attributes (e.g., `http.url`, `http.status_code`, `db.system`) without logging sensitive data.

## 4. Service Level Indicators (SLIs) and Objectives (SLOs)

- Instrument code to directly measure agreed-upon SLIs.
- Typical SLIs:
  - **Availability**: `(Successful Requests / Total Requests) * 100`
  - **Latency**: `95th percentile response time < 200ms`
- Ensure alerts are configured based on SLO burn rates, not raw metric thresholds.
