{{/*
Expand the name of the chart.
*/}}
{{- define "union-operator.name" -}}
{{- default .Chart.Name .Values.union.unionoperator.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "union-operator.namespace" -}}
{{- default .Release.Namespace .Values.forceNamespace | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "newClusterName" -}}
{{- printf "c%v" (randAlphaNum 16 | nospace | lower) -}}
{{- end -}}

{{- define "union-operator.grpcUrl" -}}
{{- printf "dns:///%s" (.Values.union.cloudUrl | trimPrefix "dns:///" | trimPrefix "http://" | trimPrefix "https://") -}}
{{- end -}}

{{- define "union-operator.cloudHostName" -}}
{{- printf "%s" (.Values.union.cloudUrl | trimPrefix "dns:///" | trimPrefix "http://" | trimPrefix "https://") -}}
{{- end -}}

{{- define "union-operator.bucketRegion" -}}
{{- if eq .Values.union.storage.type "s3" }}
{{- printf "%s" .Values.union.storage.s3.region -}}
{{- else }}
{{- printf "us-east-2" -}}
{{- end }}
{{- end }}

{{- define "union-operator.gcpProjectId" -}}
{{- if eq .Values.union.storage.type "gcs" }}
{{- printf "%s" .Values.union.storage.gcs.projectId -}}
{{- else }}
{{- printf "dummy-gcs-projectId" -}}
{{- end }}
{{- end }}

{{- define "union-operator.org" -}}
{{- (split "." (.Values.union.cloudUrl | trimPrefix "dns:///" | trimPrefix "http://" | trimPrefix "https://"))._0 -}}
{{- end -}}

{{- define "union-operator.bucket" -}}
{{- (split "/" (.Values.union.metadataBucketPrefix | trimPrefix "s3://" | trimPrefix "gs://" | trimPrefix "az://"))._0 -}}
{{- end -}}

{{- define "minio.name" -}}
minio
{{- end -}}

{{- define "minio.selectorLabels" -}}
app.kubernetes.io/name: {{ template "minio.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "minio.labels" -}}
{{ include "minio.selectorLabels" . }}
helm.sh/chart: {{ include "flyte.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
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
{{- if .Values.union.unionoperator.serviceAccount.create }}
{{- default (include "union-operator.fullname" .) .Values.union.unionoperator.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.union.unionoperator.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "union-storage.base" -}}
storage:
{{- if eq .Values.union.storage.type "s3" }}
  type: s3
  container: {{ .Values.union.storage.bucketName | quote }}
  connection:
    auth-type: {{ .Values.union.storage.s3.authType }}
    region: {{ .Values.union.storage.s3.region }}
    {{- if eq .Values.union.storage.s3.authType "accesskey" }}
    access-key: {{ .Values.union.storage.s3.accessKey }}
    secret-key: {{ .Values.union.storage.s3.secretKey }}
    {{- end }}
{{- else if eq .Values.union.storage.type "gcs" }}
  type: stow
  stow:
    kind: google
    config:
      json: ""
      project_id: {{ .Values.union.storage.gcs.projectId }}
      scopes: https://www.googleapis.com/auth/devstorage.read_write
  container: {{ .Values.union.storage.bucketName | quote }}
{{- else if eq .Values.union.storage.type "sandbox" }}
  type: minio
  container: {{ .Values.union.storage.bucketName | quote }}
  stow:
    kind: s3
    config:
      access_key_id: minio
      auth_type: accesskey
      secret_key: miniostorage
      disable_ssl: true
      endpoint: http://minio.{{ .Release.Namespace }}.svc.cluster.local:9000
      region: us-east-1
  signedUrl:
    stowConfigOverride:
      endpoint: http://localhost:30084
{{- else if eq .Values.union.storage.type "custom" }}
{{- with .Values.union.storage.custom -}}
  {{ tpl (toYaml .) $ | nindent 2 }}
{{- end }}
{{- end }}
{{- end }}

{{- define "union-storage" -}}
{{ include "union-storage.base" .}}
  enable-multicontainer: {{ .Values.union.storage.enableMultiContainer }}
  limits:
    maxDownloadMBs: {{ .Values.union.storage.limits.maxDownloadMBs }}
{{- end }}
