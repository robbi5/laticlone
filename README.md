LatiClone
==============

A small free and opensource Google Latitude clone. It displays location updates from [Big Brother GPS](http://bk.gnarf.org/creativity/bigbrothergps/) on a big map.

## Install

You need:
* **ruby** >= 1.9.3
* a running **postgresql** server (like [Postgres.app](http://postgresapp.com))
* an android smartphone with the [Big Brother GPS](http://bk.gnarf.org/creativity/bigbrothergps/) app installed
* and - if you want realtime updates - an [**pusher** account](http://pusher.com)

Create the `laticlone_dev` database:

    createdb laticlone_dev

and add the `locations` table:

    CREATE TABLE locations (
      id SERIAL,
      lat double precision,
      lon double precision,
      acc double precision,
      created_at timestamp without time zone
    );

## Startup

    DATABASE_URL="postgres://localhost/laticlone_dev" \
    PUSHER_URL="http://longauthstring@api.pusherapp.com/apps/xxxxxx" \
    ruby laticlone.rb

You can ignore the `PUSHER_URL` environment variable if you don't have an pusher account / don't want realtime updates.

## Feedback, Ideas, Contributing

Do not hesitate to use the [issues](https://github.com/robbi5/laticlone/issues) in the [main repository](https://github.com/robbi5/laticlone) for feedback, ideas or when something doesn't work.

Contributing:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request