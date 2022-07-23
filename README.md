# xk6-read-file

This is a [k6](https://go.k6.io/k6) extension using the
[xk6](https://github.com/grafana/xk6) system.

It reads file during the runtime in concurrent and thread safe manner. Each line will be read only once until 
the whole file has been read, then it will start from the beginning of the file.
The only way to preserve the read line order is to use one VU `-u 1`. 

It can be very helpful if you need to read very large files, and you don't want to store them in memory 
with [SharedArray](https://k6.io/docs/javascript-api/k6-data/sharedarray/)

## Build

To build a `k6` binary with this extension, first ensure you have the prerequisites:

- [Go toolchain](https://go101.org/article/go-toolchain.html)
- Git

Then:

1. Install `xk6`:
  ```shell
  go install go.k6.io/xk6/cmd/xk6@latest
  ```

2. Build the binary:
  ```shell
  xk6 build --with github.com/grafana/xk6-exec@latest
  ```

## Development
To make development a little smoother, use the `Makefile` in the root folder. 
It will help you create a `k6` binary with your local code rather than from GitHub.

```bash
make
```
Once built, you can run your newly extended `k6` using:
```shell
 ./k6 run -u 1 -i 200 example.js
 ```

## Example

Make sure to open and close file in `setup()` and `teardown()`

```javascript
// example.js
import readFile from 'k6/x/read-file';


export function setup() {
    readFile.openFile('data_to_read.txt')

}
export default function () {
    console.log(readFile.readLine());
}

export function teardown() {
    readFile.close()
}
```

## Thanks
Thank you [SharedArray](https://k6.io/docs/javascript-api/k6-data/sharedarray/) and https://github.com/grafana/xk6-exec for the inspiration.

## TODO
Make tests

## Licence
Apache License Version 2.0