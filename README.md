# Python Poetry Buildpack

A [Heroku](https://devcenter.heroku.com/) Buildpack for [Poetry](https://github.com/python-poetry/poetry) users.

## How to use

The Python Poetry Buildpack prepares the build to be processed by a Python buildpack such as `heroku/python` by generating `requirements.txt` and `runtime.txt` from `poetry.lock`. With that said, your repo cannot have a `requirements.txt`, it will be exported from Poetry (for `runtime.txt` see below).

To set up the use of several buildpacks from the Heroku CLI use `buildpacks:add`:

```
heroku buildpacks:clear
heroku buildpacks:add https://github.com/moneymeets/python-poetry-buildpack.git
heroku buildpacks:add heroku/python
```

**Note:** this buildpack is _only_ for generating `requirements.txt` and `runtime.txt` for subsequent use by the official `heroku/python` buildpack. Do not depend on the installed Poetry's location, or its virtual environment remaining functional at app runtime. If you need Poetry for other purposes (for example CI checks), make your own separate Poetry installation accordingly.

## Configuration

### Python

Python version can be forced by setting the `PYTHON_RUNTIME_VERSION` variable. Otherwise, it will be read from `poetry.lock`; for using Heroku default see below.

```
heroku config:set PYTHON_RUNTIME_VERSION=3.9.1
```

### `runtime.txt`

Generation of the `runtime.txt` can be skipped by setting `DISABLE_POETRY_CREATE_RUNTIME_FILE` to `1`:

```
heroku config:set DISABLE_POETRY_CREATE_RUNTIME_FILE=1
```

If `DISABLE_POETRY_CREATE_RUNTIME_FILE` is set, the required Python version can be specified in `runtime.txt`. Otherwise, if `runtime.txt` is present in the repository, the buildpack will prevent the app from being deployed in order to avoid possible ambiguities.

### Poetry

Poetry version can be specified by setting `POETRY_VERSION` in Heroku config vars. Otherwise, it will attempt to be inferred from `poetry.lock` or default to the latest version.

```
heroku config:set POETRY_VERSION=1.1.13
```

Generally all variables starting with `POETRY_` are passed on to Poetry by this buildpack; see the corresponding [Poetry documentation](https://python-poetry.org/docs/configuration/#using-environment-variables) section for possible uses.

### `requirements.txt`

Exporting of development dependencies (e.g. to run tests in CI pipelines) can be optionally enabled by setting `POETRY_EXPORT_DEV_REQUIREMENTS` to `1`:

```
heroku config:set POETRY_EXPORT_DEV_REQUIREMENTS=1
```

If you want to override the default export parameters (`--without-hashes --with-credentials`), you can set the `POETRY_EXPORT_PARAMS` config var. For example, you can use `--with-hashes` for added security, if you don't need git dependencies. This option is compatible with `POETRY_EXPORT_DEV_REQUIREMENTS` config var documented above.

```
heroku config:set POETRY_EXPORT_PARAMS=--with-hashes
```

## Contributing

To test your changes locally run the (TAP-compatible) test suite:

```
bash run_tests.sh
```
