{{/*
Expand the name of the chart.
*/}}
{{- define "union-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "clusterName" -}}
{{- randAlphaNum 16 | nospace -}}
{{- end -}}

{{- define "union-operator.grpcUrl" -}}
{{- printf "dns:///%s" (.Values.union.cloudUrl | trimPrefix "dns:///" | trimPrefix "http://" | trimPrefix "https://") -}}
{{- end -}}

{{- define "union-operator.org" -}}
{{- (split "." (.Values.union.cloudUrl | trimPrefix "dns:///" | trimPrefix "http://" | trimPrefix "https://"))._0 -}}
{{- end -}}

{{- define "union-operator.bucket" -}}
{{- (split "/" (.Values.union.metadataBucketPrefix | trimPrefix "s3://" | trimPrefix "gcs://" | trimPrefix "az://"))._0 -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "union-operator.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "union-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "union-operator.labels" -}}
helm.sh/chart: {{ include "union-operator.chart" . }}
{{ include "union-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "union-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "union-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "union-operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "union-operator.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
