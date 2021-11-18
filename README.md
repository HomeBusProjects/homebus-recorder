# homebus-recorder

This is a simple HomeBus component which subscribes to all the topics
available on a network and records all 

## Usage

You should first login to the Homebus server using `homebus-cli`. Then
when you run `homebus-recorder`, it will request permission to join
the network and when granted will start silently recording data to the server.

```
bundle exec homebus-recorder
```

## Configuration

Create a `.env` file and set the variable `MONGODB_URL` to the URL for
the MongoDB instance you want to use.
```
MONGODB_URL=mongodb+srv://username:password@hostname/databasename?retryWrites=true&w=majority
```

## TODO

- read list of published DDCs from `org.experimental.homebus.devices`
- provide a way to exclude DDCs
- provide a way to exclude devices
- provide a way to expire data
