# Python Poetry Buildpack

A [Heroku](https://devcenter.heroku.com/) Buildpack for [Poetry](https://github.com/python-poetry/poetry) users.

## How to use

The Python Poetry Buildpack prepares the build to be processed by a python buildpack such as `heroku/python`. To set up the use of several buildpacks from the heroku CLI use `buildpacks:add`:

```
heroku buildpacks:clear
heroku buildpacks:add https://github.com/moneymeets/python-poetry-buildpack.git
heroku buildpacks:add heroku/python
```
