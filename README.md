# union-operator

![Version: v0.1.0](https://img.shields.io/badge/Version-v0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: operator-92d34872d46545f56e6808c12d6c602e2c6a95bf](https://img.shields.io/badge/AppVersion-operator--92d34872d46545f56e6808c12d6c602e2c6a95bf-informational?style=flat-square)

Deploys Union Operator to onboard a k8s cluster to Union Cloud

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://flyteorg.github.io/flyte/ | union(flyte-core) | v0.18.2 |

### SANDBOX INSTALLATION:
- [Install helm 3](https://helm.sh/docs/intro/install/)
- Install Flyte sandbox:

```bash
git clone git@github.com:unionai/unionoperator.git
cd unionoperator
helm install -n union-operator -f values.yaml --create-namespace union-operator .
```

Customize your installation by changing settings in a new file `values.yaml`.

Then apply your changes:
```bash
helm upgrade -f values.yaml union-operator . -n union-operator
```

### CONFIGURATION NOTES:

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| union | object | `{"appId":"<App Id from uctl create app>","appSecret":"<App secret from uctl create app>","cloudUrl":"<Union Cloud URL>","clusterName":"","common":{"ingress":{"enabled":false}},"configmap":{"admin":{"admin":{"clientId":"{{ tpl .Values.appId . }}","clientSecretLocation":"/etc/secrets/client_secret","endpoint":"{{- (split \".\" (.Values.cloudUrl | trimPrefix \"dns:///\" | trimPrefix \"http://\" | trimPrefix \"https://\"))._0 -}}"},"event":{"capacity":1000,"rate":500,"type":"admin"}},"catalog":{"catalog-cache":{"endpoint":"{{- (split \".\" (.Values.cloudUrl | trimPrefix \"dns:///\" | trimPrefix \"http://\" | trimPrefix \"https://\"))._0 -}}","type":"datacatalog"}},"core":{"propeller":{"downstream-eval-duration":"30s","enable-admin-launcher":true,"leader-election":{"enabled":false,"lease-duration":"15s","lock-config-map":{"name":"propeller-leader","namespace":"flyte"},"renew-deadline":"10s","retry-period":"2s"},"limit-namespace":"all","max-workflow-retries":30,"metadata-prefix":"metadata/propeller","metrics-prefix":"flyte","prof-port":10254,"queue":{"batch-size":-1,"batching-interval":"2s","queue":{"base-delay":"5s","capacity":1000,"max-delay":"120s","rate":100,"type":"maxof"},"sub-queue":{"capacity":100,"rate":10,"type":"bucket"},"type":"batch"},"rawoutput-prefix":"{{ tpl .Values.metadataBucketPrefix $ }}","workers":4,"workflow-reeval-duration":"30s"},"webhook":{"certDir":"/etc/webhook/certs","serviceName":"flyte-pod-webhook"}},"enabled_plugins":{"tasks":{"task-plugins":{"default-for-task-types":{"container":"container","container_array":"k8s-array","sidecar":"sidecar"},"enabled-plugins":["container","sidecar","k8s-array"]}}},"k8s":{"plugins":{"k8s":{"default-cpus":"100m","default-env-vars":[],"default-memory":"100Mi"}}},"logger":{"logger":{"level":4,"show-source":true}},"resource_manager":{"propeller":{"resourcemanager":{"type":"noop"}}},"task_logs":{"plugins":{"logs":{"cloudwatch-enabled":false,"kubernetes-enabled":true}}}},"datacatalog":{"enabled":false},"flyteadmin":{"enabled":false},"flyteconsole":{"enabled":false},"flytepropeller":{"affinity":{},"cacheSizeMbs":0,"client_secret":"foobar","configPath":"/etc/flyte/config/*.yaml","enabled":true,"nodeSelector":{},"podAnnotations":{},"replicaCount":1,"resources":{"limits":{"cpu":"200m","ephemeral-storage":"100Mi","memory":"200Mi"},"requests":{"cpu":"10m","ephemeral-storage":"50Mi","memory":"50Mi"}},"serviceAccount":{"annotations":{},"create":true,"imagePullSecrets":{}},"tolerations":[]},"flytescheduler":{"enabled":false},"metadataBucketPrefix":"s3://my-s3-bucket","sparkoperator":{"enabled":false,"plugin_config":{"plugins":{"spark":{"spark-config-default":[{"spark.hadoop.fs.s3a.aws.credentials.provider":"com.amazonaws.auth.DefaultAWSCredentialsProviderChain"},{"spark.hadoop.mapreduce.fileoutputcommitter.algorithm.version":"2"},{"spark.kubernetes.allocation.batch.size":"50"},{"spark.hadoop.fs.s3a.acl.default":"BucketOwnerFullControl"},{"spark.hadoop.fs.s3n.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3n.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3a.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.multipart.threshold":"536870912"},{"spark.blacklist.enabled":"true"},{"spark.blacklist.timeout":"5m"},{"spark.task.maxfailures":"8"}]}}}},"unionoperator":{"affinity":{},"autoscaling":{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80},"configmapOverrides":{},"fullnameOverride":"","image":{"pullPolicy":"IfNotPresent","repository":"public.ecr.aws/p0i0a9q8/union-public","tag":""},"imagePullSecrets":[],"nameOverride":"","nodeSelector":{},"podAnnotations":{"prometheus.io/path":"/metrics","prometheus.io/port":"10254","prometheus.io/scrape":"true"},"podSecurityContext":{},"replicaCount":1,"resources":{},"securityContext":{},"service":{"port":80,"type":"ClusterIP"},"serviceAccount":{"annotations":{},"create":true,"name":""},"storage":{"custom":{},"gcs":null,"s3":{"region":"us-east-1"},"type":"sandbox"},"tolerations":[]},"webhook":{"enabled":true,"podAnnotations":{},"service":{"annotations":{"projectcontour.io/upstream-protocol.h2c":"grpc"},"type":"ClusterIP"},"serviceAccount":{"annotations":{},"create":true,"imagePullSecrets":{}}}}` |  This is a YAML-formatted file. Declare variables to be passed into your templates. |
| union.configmap | object | `{"admin":{"admin":{"clientId":"{{ tpl .Values.appId . }}","clientSecretLocation":"/etc/secrets/client_secret","endpoint":"{{- (split \".\" (.Values.cloudUrl | trimPrefix \"dns:///\" | trimPrefix \"http://\" | trimPrefix \"https://\"))._0 -}}"},"event":{"capacity":1000,"rate":500,"type":"admin"}},"catalog":{"catalog-cache":{"endpoint":"{{- (split \".\" (.Values.cloudUrl | trimPrefix \"dns:///\" | trimPrefix \"http://\" | trimPrefix \"https://\"))._0 -}}","type":"datacatalog"}},"core":{"propeller":{"downstream-eval-duration":"30s","enable-admin-launcher":true,"leader-election":{"enabled":false,"lease-duration":"15s","lock-config-map":{"name":"propeller-leader","namespace":"flyte"},"renew-deadline":"10s","retry-period":"2s"},"limit-namespace":"all","max-workflow-retries":30,"metadata-prefix":"metadata/propeller","metrics-prefix":"flyte","prof-port":10254,"queue":{"batch-size":-1,"batching-interval":"2s","queue":{"base-delay":"5s","capacity":1000,"max-delay":"120s","rate":100,"type":"maxof"},"sub-queue":{"capacity":100,"rate":10,"type":"bucket"},"type":"batch"},"rawoutput-prefix":"{{ tpl .Values.metadataBucketPrefix $ }}","workers":4,"workflow-reeval-duration":"30s"},"webhook":{"certDir":"/etc/webhook/certs","serviceName":"flyte-pod-webhook"}},"enabled_plugins":{"tasks":{"task-plugins":{"default-for-task-types":{"container":"container","container_array":"k8s-array","sidecar":"sidecar"},"enabled-plugins":["container","sidecar","k8s-array"]}}},"k8s":{"plugins":{"k8s":{"default-cpus":"100m","default-env-vars":[],"default-memory":"100Mi"}}},"logger":{"logger":{"level":4,"show-source":true}},"resource_manager":{"propeller":{"resourcemanager":{"type":"noop"}}},"task_logs":{"plugins":{"logs":{"cloudwatch-enabled":false,"kubernetes-enabled":true}}}}` | ------------------------------------------------------------------ Specializing your deployment using configuration ------------------------------------------------------------------- CONFIGMAPS SETTINGS |
| union.configmap.admin | object | `{"admin":{"clientId":"{{ tpl .Values.appId . }}","clientSecretLocation":"/etc/secrets/client_secret","endpoint":"{{- (split \".\" (.Values.cloudUrl | trimPrefix \"dns:///\" | trimPrefix \"http://\" | trimPrefix \"https://\"))._0 -}}"},"event":{"capacity":1000,"rate":500,"type":"admin"}}` | Admin Client configuration [structure](https://pkg.go.dev/github.com/flyteorg/flytepropeller/pkg/controller/nodes/subworkflow/launchplan#AdminConfig) |
| union.configmap.catalog | object | `{"catalog-cache":{"endpoint":"{{- (split \".\" (.Values.cloudUrl | trimPrefix \"dns:///\" | trimPrefix \"http://\" | trimPrefix \"https://\"))._0 -}}","type":"datacatalog"}}` | Catalog Client configuration [structure](https://pkg.go.dev/github.com/flyteorg/flytepropeller/pkg/controller/nodes/task/catalog#Config) Additional advanced Catalog configuration [here](https://pkg.go.dev/github.com/lyft/flyteplugins/go/tasks/pluginmachinery/catalog#Config) |
| union.configmap.core | object | `{"propeller":{"downstream-eval-duration":"30s","enable-admin-launcher":true,"leader-election":{"enabled":false,"lease-duration":"15s","lock-config-map":{"name":"propeller-leader","namespace":"flyte"},"renew-deadline":"10s","retry-period":"2s"},"limit-namespace":"all","max-workflow-retries":30,"metadata-prefix":"metadata/propeller","metrics-prefix":"flyte","prof-port":10254,"queue":{"batch-size":-1,"batching-interval":"2s","queue":{"base-delay":"5s","capacity":1000,"max-delay":"120s","rate":100,"type":"maxof"},"sub-queue":{"capacity":100,"rate":10,"type":"bucket"},"type":"batch"},"rawoutput-prefix":"{{ tpl .Values.metadataBucketPrefix $ }}","workers":4,"workflow-reeval-duration":"30s"},"webhook":{"certDir":"/etc/webhook/certs","serviceName":"flyte-pod-webhook"}}` | Core propeller configuration |
| union.configmap.core.propeller | object | `{"downstream-eval-duration":"30s","enable-admin-launcher":true,"leader-election":{"enabled":false,"lease-duration":"15s","lock-config-map":{"name":"propeller-leader","namespace":"flyte"},"renew-deadline":"10s","retry-period":"2s"},"limit-namespace":"all","max-workflow-retries":30,"metadata-prefix":"metadata/propeller","metrics-prefix":"flyte","prof-port":10254,"queue":{"batch-size":-1,"batching-interval":"2s","queue":{"base-delay":"5s","capacity":1000,"max-delay":"120s","rate":100,"type":"maxof"},"sub-queue":{"capacity":100,"rate":10,"type":"bucket"},"type":"batch"},"rawoutput-prefix":"{{ tpl .Values.metadataBucketPrefix $ }}","workers":4,"workflow-reeval-duration":"30s"}` | follows the structure specified [here](https://pkg.go.dev/github.com/flyteorg/flytepropeller/pkg/controller/config). |
| union.configmap.enabled_plugins.tasks | object | `{"task-plugins":{"default-for-task-types":{"container":"container","container_array":"k8s-array","sidecar":"sidecar"},"enabled-plugins":["container","sidecar","k8s-array"]}}` | Tasks specific configuration [structure](https://pkg.go.dev/github.com/flyteorg/flytepropeller/pkg/controller/nodes/task/config#GetConfig) |
| union.configmap.enabled_plugins.tasks.task-plugins | object | `{"default-for-task-types":{"container":"container","container_array":"k8s-array","sidecar":"sidecar"},"enabled-plugins":["container","sidecar","k8s-array"]}` | Plugins configuration, [structure](https://pkg.go.dev/github.com/flyteorg/flytepropeller/pkg/controller/nodes/task/config#TaskPluginConfig) |
| union.configmap.enabled_plugins.tasks.task-plugins.enabled-plugins | list | `["container","sidecar","k8s-array"]` | [Enabled Plugins](https://pkg.go.dev/github.com/lyft/flyteplugins/go/tasks/config#Config). Enable sagemaker*, athena if you install the backend plugins |
| union.configmap.k8s | object | `{"plugins":{"k8s":{"default-cpus":"100m","default-env-vars":[],"default-memory":"100Mi"}}}` | Kubernetes specific Flyte configuration |
| union.configmap.k8s.plugins.k8s | object | `{"default-cpus":"100m","default-env-vars":[],"default-memory":"100Mi"}` | Configuration section for all K8s specific plugins [Configuration structure](https://pkg.go.dev/github.com/lyft/flyteplugins/go/tasks/pluginmachinery/flytek8s/config) |
| union.configmap.logger | object | `{"logger":{"level":4,"show-source":true}}` | Logger configuration |
| union.configmap.resource_manager | object | `{"propeller":{"resourcemanager":{"type":"noop"}}}` | Resource manager configuration |
| union.configmap.resource_manager.propeller | object | `{"resourcemanager":{"type":"noop"}}` | resource manager configuration |
| union.configmap.task_logs | object | `{"plugins":{"logs":{"cloudwatch-enabled":false,"kubernetes-enabled":true}}}` | Section that configures how the Task logs are displayed on the UI. This has to be changed based on your actual logging provider. Refer to [structure](https://pkg.go.dev/github.com/lyft/flyteplugins/go/tasks/logs#LogConfig) to understand how to configure various logging engines |
| union.configmap.task_logs.plugins.logs.cloudwatch-enabled | bool | `false` | One option is to enable cloudwatch logging for EKS, update the region and log group accordingly |
| union.flytepropeller.affinity | object | `{}` | affinity for Flytepropeller deployment |
| union.flytepropeller.configPath | string | `"/etc/flyte/config/*.yaml"` | Default regex string for searching configuration files |
| union.flytepropeller.nodeSelector | object | `{}` | nodeSelector for Flytepropeller deployment |
| union.flytepropeller.podAnnotations | object | `{}` | Annotations for Flytepropeller pods |
| union.flytepropeller.replicaCount | int | `1` | Replicas count for Flytepropeller deployment |
| union.flytepropeller.resources | object | `{"limits":{"cpu":"200m","ephemeral-storage":"100Mi","memory":"200Mi"},"requests":{"cpu":"10m","ephemeral-storage":"50Mi","memory":"50Mi"}}` | Default resources requests and limits for Flytepropeller deployment |
| union.flytepropeller.serviceAccount | object | `{"annotations":{},"create":true,"imagePullSecrets":{}}` | Configuration for service accounts for FlytePropeller |
| union.flytepropeller.serviceAccount.annotations | object | `{}` | Annotations for ServiceAccount attached to FlytePropeller pods |
| union.flytepropeller.serviceAccount.create | bool | `true` | Should a service account be created for FlytePropeller |
| union.flytepropeller.serviceAccount.imagePullSecrets | object | `{}` | ImapgePullSecrets to automatically assign to the service account |
| union.flytepropeller.tolerations | list | `[]` | tolerations for Flytepropeller deployment |
| union.sparkoperator | object | `{"enabled":false,"plugin_config":{"plugins":{"spark":{"spark-config-default":[{"spark.hadoop.fs.s3a.aws.credentials.provider":"com.amazonaws.auth.DefaultAWSCredentialsProviderChain"},{"spark.hadoop.mapreduce.fileoutputcommitter.algorithm.version":"2"},{"spark.kubernetes.allocation.batch.size":"50"},{"spark.hadoop.fs.s3a.acl.default":"BucketOwnerFullControl"},{"spark.hadoop.fs.s3n.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3n.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3a.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.multipart.threshold":"536870912"},{"spark.blacklist.enabled":"true"},{"spark.blacklist.timeout":"5m"},{"spark.task.maxfailures":"8"}]}}}}` | ------------------------------------------------------ Optional Plugins -------------------------------------------------------- -- Optional: Spark Plugin using the Spark Operator |
| union.sparkoperator.enabled | bool | `false` | - enable or disable Sparkoperator deployment installation |
| union.sparkoperator.plugin_config | object | `{"plugins":{"spark":{"spark-config-default":[{"spark.hadoop.fs.s3a.aws.credentials.provider":"com.amazonaws.auth.DefaultAWSCredentialsProviderChain"},{"spark.hadoop.mapreduce.fileoutputcommitter.algorithm.version":"2"},{"spark.kubernetes.allocation.batch.size":"50"},{"spark.hadoop.fs.s3a.acl.default":"BucketOwnerFullControl"},{"spark.hadoop.fs.s3n.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3n.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3a.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.multipart.threshold":"536870912"},{"spark.blacklist.enabled":"true"},{"spark.blacklist.timeout":"5m"},{"spark.task.maxfailures":"8"}]}}}` | Spark plugin configuration |
| union.sparkoperator.plugin_config.plugins.spark.spark-config-default | list | `[{"spark.hadoop.fs.s3a.aws.credentials.provider":"com.amazonaws.auth.DefaultAWSCredentialsProviderChain"},{"spark.hadoop.mapreduce.fileoutputcommitter.algorithm.version":"2"},{"spark.kubernetes.allocation.batch.size":"50"},{"spark.hadoop.fs.s3a.acl.default":"BucketOwnerFullControl"},{"spark.hadoop.fs.s3n.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3n.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3a.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.multipart.threshold":"536870912"},{"spark.blacklist.enabled":"true"},{"spark.blacklist.timeout":"5m"},{"spark.task.maxfailures":"8"}]` | Spark default configuration |
| union.sparkoperator.plugin_config.plugins.spark.spark-config-default[0] | object | `{"spark.hadoop.fs.s3a.aws.credentials.provider":"com.amazonaws.auth.DefaultAWSCredentialsProviderChain"}` |  it can use the serviceAccount based IAM role or ec2 metadata based. This is more in line with how AWS works |
| union.unionoperator.serviceAccount.name | string | `""` |  If not set and create is true, a name is generated using the fullname template |
| union.unionoperator.storage.custom | object | `{}` | GCP project ID. Required for storage type gcs. projectId: -- Settings for storage type custom. See https://github:com/graymeta/stow for supported storage providers/settings. |
| union.unionoperator.storage.gcs | string | `nil` | settings for storage type gcs |
| union.unionoperator.storage.s3 | object | `{"region":"us-east-1"}` | settings for storage type s3 |
| union.unionoperator.storage.type | string | `"sandbox"` | Sets the storage type. Supported values are sandbox, s3, gcs and custom. |
| union.webhook | object | `{"enabled":true,"podAnnotations":{},"service":{"annotations":{"projectcontour.io/upstream-protocol.h2c":"grpc"},"type":"ClusterIP"},"serviceAccount":{"annotations":{},"create":true,"imagePullSecrets":{}}}` |  WEBHOOK SETTINGS |
| union.webhook.enabled | bool | `true` | enable or disable secrets webhook |
| union.webhook.podAnnotations | object | `{}` | Annotations for webhook pods |
| union.webhook.service | object | `{"annotations":{"projectcontour.io/upstream-protocol.h2c":"grpc"},"type":"ClusterIP"}` | Service settings for the webhook |
| union.webhook.serviceAccount | object | `{"annotations":{},"create":true,"imagePullSecrets":{}}` | Configuration for service accounts for the webhook |
| union.webhook.serviceAccount.annotations | object | `{}` | Annotations for ServiceAccount attached to the webhook |
| union.webhook.serviceAccount.create | bool | `true` | Should a service account be created for the webhook |
| union.webhook.serviceAccount.imagePullSecrets | object | `{}` | ImapgePullSecrets to automatically assign to the service account |
