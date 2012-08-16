This is a very simple dashboard application. It is designed to aggregate graphs, etc. from various places so that you can see them all in one place.

## Features

* LDAP authentication.
* Automatic account creation on first logon.
* Global list of 'metrics' (individual graph, say)
* Ability to make multiple 'portals' (dashboards)
* Add and remove metrics from portals as you see fit.

## Metrics

A metric is a single graph, say, or whatever you wish. When you create a metric, you put in an HTML snippet in to the snippet box and that is what will be rendered.

The snippet could be something like:

```html
    <img src="<url of your graph image here>" >
```

If it can be rendered as an HTML snippet, it can be a metric.

## Setup

This is a Rails app, so the usual rituals apply.

* bundle install
* cp config/ldap.yml.example config/ldap.yml and edit accordingly
* cp config/database.yml.example config/database.yml and edit accordingly
* rake db:migrate
* rails s

## Credits

A big thanks goes to Doug Tschetter for his css help. The reason why this looks so nice is all down to hm. 