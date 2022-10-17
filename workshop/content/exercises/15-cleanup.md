
```execute
tanzu accelerator delete {{ session_namespace }} -y
```

```execute
tanzu apps workload list -n tap-install
```

```execute
tanzu apps workload delete {{ session_namespace }} -n tap-install
```

```execute
tanzu apps workload delete {{ session_namespace }}-a -n tap-install
```

```execute
tanzu apps workload list -n tap-install
```
