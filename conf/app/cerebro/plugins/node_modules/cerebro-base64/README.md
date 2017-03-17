# cerebro-base64
Cerebro plugin to decode and encode buffer using base64 methods

## Base usage

![Cerebro-base64](https://raw.githubusercontent.com/Krbz/cerebro-base64/master/cerebro-base64.gif)

```javascript
base64 [method] [buffer]
```
* [method] - `look at [API](https://github.com/Krbz/cerebro-base64#api)`
* [buffer] - `Any string, depends on method`

## API
Start typing 'base64' keyword. Cerebro searcher should render all methods.

### Available Methods

* Encode
Encodes a buffer to base64, returns encoded ascii string

```ssh
$ base64 decode it's awesome
```
Should Render base64 buffer
```ssh
= aXQncyBhd2Vzb21l
```

* Decode
Decodes a buffer containing base64 string to ascii string.

```ssh
base64 decode aXQncyBhd2Vzb21l
```
Should Render ascii buffer
```ssh
= it's awesome
```

## Related

* [Cerebro](http://github.com/KELiON/cerebro) – main repo for Cerebro app;
* [cerebro tools](http://github.com/KELiON/cerebro-tools) – package with tools to simplify package creation;

## License
MIT © [Krystian Błaszczyk](https://github.com/Krbz)
