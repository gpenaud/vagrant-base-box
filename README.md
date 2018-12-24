# __Create-Base-Box - Génère des boxes pour vagrant__

### documentation

```
make help
```

### pré-checks

```
make test
```

### build images:

```
make container jessie
make container stretch

make vm jessie
make vm stretch
```


### debug des images:

```
sctl status dnsmasq@lxc
```

pour voir si le dns attribue bien une ip au container
