# README

## Executing locally

### Basic Configuration

In `.env.development.local`, enter values for those.

```
HARVEST_ACCESS_TOKEN=
HARVEST_ACCOUNT_ID=
```

Create a development topen [here](https://id.getharvest.com/developers).

After creating the coken, choose the account you want to monitor. It's *Account
ID* will appear under it.

```
HARVEST_USER_ID=
```

When connected to *Harvest*, click on your name (top-right) and then _My
Profile_. Your _user ID_ will be displayed in the URL (`/people/12345/edit`).

### Start Dev Server

```
bin/dev
```
