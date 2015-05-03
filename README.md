#### Sendthistome extensions

The extension(s) configuration and platform-specific details live in the `extensions/` folder, while the majority of the actual extension code lives in `src`. Gulp copies these structures and injects the compiled reources from `src` into the formatted directories in `dist`.

To install locally, first build the extensions:

```
$ npm install && npm install -g bower gulp
$ bower install
$ gulp
```

Then install the extensions to your browser. See [Babel Ext's notes](https://github.com/honestbleeps/BabelExt#instructions-for-loadingtesting-an-extension-in-each-browser).


#### Credit:
Shoutout to [BabelExt](https://github.com/honestbleeps/BabelExt) for the structure of every extension.