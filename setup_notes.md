## How it was built

```
mix new relay_race --umbrella
cd relay_race/apps/
mix nerves.new fw --target rpi3
```

### To add phoenix

```
cd apps
mix phoenix.new web_interface --no-ecto --no-brunch
```

### To add discovery

```
mkdir util
cd util
mix new discovery
```
