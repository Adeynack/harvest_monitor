# README

## Executing locally

### Basic Configuration

In `.env.development.local`, enter values for those.

```
HARVEST_ACCESS_TOKEN=
HARVEST_ACCOUNT_ID=
```

Create a development token [here](https://id.getharvest.com/developers).

After creating the token, choose the account you want to monitor. It's *Account
ID* will appear under it.

```
HARVEST_USER_ID=
```

When connected to *Harvest*, click on your name (top-right) and then _My
Profile_. Your _user ID_ will be displayed in the URL (`/people/12345/edit`).

### Start Dev Server

If you want to keep it running while working on other Rails projects, specify
a port:

```
PORT=3001 bin/dev
```

And then open [http://localhost:3001](http://localhost:3001).
