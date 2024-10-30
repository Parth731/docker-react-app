- `docker build -f Dockerfile.dev .`

```js
 "scripts": {
    "start": "WATCHPACK_POLLING=true react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
```

- While using react-scripts 5.0.1, CHOKIDAR_USEPOLLING didn't function as expected but setting WATCHPACK_POLLING = True did the trick.

- `docker run -p 4000:3000 -v /react-dev-app/node_modules -v ${PWD}:/react-dev-app 636af2fa9cea57f02e84e131d50ecdb0303d24281c5814fcdb2b4c4865db5065`
