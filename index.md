# Union Helm Registry

Add this repository using:

```bash
$ helm repo add unionai https://helm.union.ai
$ helm repo update
```

## Union Operator Helm Chart

The Union Operator Helm Chart helps you to onboard a k8s cluster to Union Cloud

### Install Union Operator

To install Union Operator, the following
[configuration values]()
must be set:

- `union.appId`
- `union.cloudUrl`
- `union.clusterName`
- `union.appSecret`
- `union.metadataBucketPrefix`

You can create a `values.yaml` file to set the required values, like so:

```yaml
union:
  cloudUrl: <Union Cloud URL>
  appId: <App Id from uctl create app>
  appSecret: <App secret from uctl create app>
  metadataBucketPrefix: s3://my-s3-bucket
  clusterName: ""
```

Install Union Operator by running this command:

```bash
$ helm install -n union-operator -f values.yaml --create-namespace union-operator unionai/union-operator 
```

### Upgrade Union Operator

```bash
$ helm upgrade -n union-operator -f values.yaml --create-namespace union-operator unionai/union-operator
```
