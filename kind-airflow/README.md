# Airflow 3 on KinD

Apache Airflow version tested: 3.2.2; the latest version 3.3.2 is not available
in the Helm repository currently.

## Install all prerequisite tools

```console
$ pwd
<path-to-repository>/krish7919/gyan

# Install all dependencies.
$ mise install
mise all tools are installed

$ kind --version
kind version 0.33.0

$ kubectl version
Client Version: v1.37.0
Kustomize Version: v5.8.1
Server Version: v1.37.0

$ helm version
version.BuildInfo{Version:"v4.3.1", GitCommit:"c0d08d0d6d9424d4a14febb5e8a3e51b0dd00dff", GitTreeState:"clean", GoVersion:"go1.27.2", KubeClientVersion:"v1.37"}

# Enable autocompletions; required as tools were installed using `mise`.
$ source <(kind completion zsh)
$ source <(kubectl completion zsh)
$ source <(helm completion zsh)
```

## Start the K8s cluster

```console
$ pwd
<path-to-repository>/krish7919/gyan/kind-airflow

# Create the local k8s cluster
$ kind create cluster \
    --image=kindest/node:v1.37.0 \
    --name=local-kubernetes-cluster \
    --config=./kind-config.yaml \
    --wait=120s

# Verify
$ kubectl cluster-info --context kind-local-kubernetes-cluster

# Switch kubectl config to point to local cluster
$ kubectl config get-contexts
$ kubectl config set-context kind-local-kubernetes-cluster

# Test k8s cluster setup and kubectl connectivity
$ kubectl get nodes
NAME                                     STATUS   ROLES           AGE     VERSION
local-kubernetes-cluster-control-plane   Ready    control-plane   3m53s   v1.37.0
local-kubernetes-cluster-worker          Ready    <none>          3m43s   v1.37.0
local-kubernetes-cluster-worker2         Ready    <none>          3m43s   v1.37.0
```

## Install postgres

```console
$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm repo update
$ helm search repo bitnami/postgresql
$ helm show chart bitnami/postgresql
$ helm show values bitnami/postgresql > postgres-default-values.yaml

# Create namespace.
$ kubectl create namespace postgres
$ kubectl get namespaces

# Install postgres chart
$ helm upgrade --install \
    postgres bitnami/postgresql \
    --namespace=postgres \
    --wait \
    --values ./postgres-values.yaml

# Connect to postgres
$ export POSTGRES_PASSWORD=$(kubectl get secret --namespace postgres postgres-postgresql -o jsonpath="{.data.password}" | base64 -d)
$ echo $POSTGRES_PASSWORD
password

$ kubectl port-forward --namespace postgres svc/postgres-postgresql 5432:5432
Forwarding from 127.0.0.1:5432 -> 5432
Forwarding from [::1]:5432 -> 5432

$ PGPASSWORD="$POSTGRES_PASSWORD" psql \
    --host=127.0.0.1 \
    --username=user \
    --dbname=airflow \
    --port=5432
```

## Install airflow chart

```console
$ helm repo add apache-airflow https://airflow.apache.org
$ helm repo update
$ helm search repo apache-airflow/airflow
$ helm show chart apache-airflow/airflow
$ helm show values apache-airflow/airflow > airflow-default-values.yaml

# Create namespace.
$ kubectl create namespace airflow
$ kubectl get namespaces

# Install airflow chart
$ helm upgrade --install \
    airflow apache-airflow/airflow \
    --namespace=airflow \
    --wait \
    --values ./airflow-values.yaml
```

### Connect to Airflow UI/Airflow API Server

```console
$ kubectl port-forward svc/airflow-api-server 8080:8080 --namespace airflow
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
```

Access the Airflow UI at <http://localhost:8080/dags>

Default user (Airflow UI) Login credentials:
   username: admin
   password: admin

## Test and verification steps

### Check that both the Helm charts are deployed successfully

```console
$ helm list --all-namespaces
NAME     NAMESPACE REVISION UPDATED                              STATUS   CHART              APP VERSION
airflow  airflow   1        2026-10-16 22:18:01.447436 +0100 BST deployed airflow-1.22.0     3.2.2      
postgres postgres  1        2026-10-16 15:12:08.441845 +0100 BST deployed postgresql-18.12.4 18.6.0     
```

### Connect to the psql console and check that database entities are created successfully

```console
airflow=> \ds
                      List of sequences
 Schema |               Name               |   Type   | Owner 
--------+----------------------------------+----------+-------
 public | ab_group_id_seq                  | sequence | user
 public | ab_group_role_id_seq             | sequence | user
 ...
 ...
 public | trigger_id_seq                   | sequence | user
 public | variable_id_seq                  | sequence | user
(29 rows)

airflow=> \dt
                       List of tables
 Schema |                Name                | Type  | Owner 
--------+------------------------------------+-------+-------
 public | ab_group                           | table | user
 public | ab_group_role                      | table | user
 ...
 ...
 public | trigger                            | table | user
 public | variable                           | table | user
 public | xcom                               | table | user
(68 rows)
```

## Cleanup

```console
# Uninstall airflow from the cluster
$ helm uninstall --namespace airflow  airflow

# Uninstall postgres from the cluster
$ helm uninstall --namespace postgres postgres

# Stop the cluster
$ kind delete cluster \
    --name local-kubernetes-cluster
```
