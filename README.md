# finbots-dev

## configure

- [ ] initialize build harness using command `make init`
- [ ] copy project vars.example file `make vars`
- [ ] ensure software dependencies are installed `make brew`
- [ ] execute all of the commands above at once using default configuration `make`

## clone dependent service source code repositories

```sh
  make
```

- iterate the repo-manifest file and call git clone or update for each entry
- iterate the repo-manifest file and initialize each repo found
